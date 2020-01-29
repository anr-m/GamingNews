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
    var totalArticlesCount = 0
    var isLoadingInProgress = false
    var url: String {
        fatalError("Must override this property")
    }
    var segueIdentifier: String {
        fatalError("Must override this property")
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
    }

    // MARK: - Fetch news from API method
    func getNews() {
        
        guard !isLoadingInProgress else {
            return
        }
        
        isLoadingInProgress = true
        
        ArticlesProvider.get(url: url, page: currentPage) { [weak self] (searchResult) in
            
            guard let self = self else {
                return
            }
            
            // Show alert if no articles were fetched
            guard let totalResults = searchResult.totalResults, let articles = searchResult.articles else {
                if let errorMessage = searchResult.message {
                    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Dismiss", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                // Delete unfilled cells
                self.totalArticlesCount -= (self.totalArticlesCount - self.articles.count)
                self.tableView.reloadData()
                return
            }
            
            self.totalArticlesCount = totalResults
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
    
    // MARK: - Swipe to bookmark method
    func bookmarkArticle(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Bookmark") { (UIContextualAction, UIView, completionHandler: (Bool) -> Void) in
            // Realm write methods
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
    
    // MARK: - Navigation
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

