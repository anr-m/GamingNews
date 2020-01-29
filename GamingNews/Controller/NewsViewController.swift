//
//  ParentViewController.swift
//  GamingNews
//
//  Created by Anuar on 1/28/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import UIKit
import RealmSwift

// Parent class for common functionality
class ParentViewController: UITableViewController {
    
    let realm = try! Realm()
    var articles: [Article] = []
    var currentPage = 1
    var totalArticles = 0
    var isLoadingInProgress = false
    var url: String {
        fatalError("Must override this property")
    }
    var segueIdentifier: String {
        fatalError("Must override this property")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
    }

    func getNews() {
        
        guard !isLoadingInProgress else {
            return
        }
        
        isLoadingInProgress = true
        
        ArticlesProvider.get(url: url, page: currentPage) { [weak self] (searchResult) in
            
            guard let self = self else {
                return
            }
            
            guard let totalResults = searchResult.totalResults, let articles = searchResult.articles else {
                if let errorMessage = searchResult.message {
                    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Dismiss", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            self.totalArticles = totalResults > 100 ? 100 : totalResults
            self.articles.append(contentsOf: articles)
            self.isLoadingInProgress = false
            if self.currentPage > 1 {
                let newIndexPathsToReload = self.calculateIndexPathsToReload(from: articles)
                self.onLoadCompleted(with: newIndexPathsToReload)
            } else {
                self.tableView.reloadData()
            }
            self.currentPage += 1
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalArticles
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let articleCell = Bundle.main.loadNibNamed("ArticleCell", owner: self, options: nil)?.first as? ArticleCell else {
            return UITableViewCell()
        }
        
        if isLoadingCell(for: indexPath) {
            let activityIndicator = UIActivityIndicatorView()
            articleCell.addSubview(activityIndicator)
            activityIndicator.center = articleCell.center
            activityIndicator.startAnimating()
        } else {
            articleCell.configure(with: articles[indexPath.row])
        }
        
        return articleCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: articles[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        return UISwipeActionsConfiguration(actions: [self.bookmarkArticle(at: indexPath)])
    }
    
    func bookmarkArticle(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Bookmark") { (UIContextualAction, UIView, completionHandler: (Bool) -> Void) in
            do {
                try self.realm.write {
                    let articleCached = ArticleCached(article: self.articles[indexPath.row])
                    if let cell = self.tableView.cellForRow(at: indexPath) as? ArticleCell {
                        if let imageData = cell.thumbnailView.image?.pngData() {
                            articleCached.imageData = imageData
                        }
                    }
                    self.realm.add(articleCached, update: .all)
                    completionHandler(true)
                }
            } catch {
                print("Error saving article: \(error)")
                completionHandler(false)
            }
        }
        
        action.image = UIImage(systemName: "star.fill")
        action.backgroundColor = UIColor.blue
        
        return action
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueIdentifier else {
            return
        }
        
        if let articleVC = segue.destination as? ArticleViewController {
            if let article = sender as? Article {
                articleVC.article = article
            }
        }
    }

}

extension ParentViewController: UITableViewDataSourcePrefetching {
    
    func calculateIndexPathsToReload(from newArticles: [Article]) -> [IndexPath] {
      let startIndex = articles.count - newArticles.count
      let endIndex = startIndex + newArticles.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= articles.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
      let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
          getNews()
        }
    }
    
    func onLoadCompleted(with newIndexPathsToReload: [IndexPath]) {
      
//      guard let newIndexPathsToReload = newIndexPathsToReload else {
//        tableView.reloadData()
//        return
//      }
      
      let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
      tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
}
