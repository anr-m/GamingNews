//
//  BookmarksViewController.swift
//  GamingNews
//
//  Created by Anuar on 1/29/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import UIKit
import RealmSwift

class BookmarksViewController: UITableViewController {

    let realm = try! Realm()
    var articles: Results<ArticleCached>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadData()
    }
    
    func reloadData() {
        articles = realm.objects(ArticleCached.self)
        tableView.reloadData()
    }

    // MARK: - Swipe to delete method
    func deleteArticle(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (UIContextualAction, UIView, completionHandler: (Bool) -> Void) in
            
            if let articleToDelete = self.articles?[indexPath.row] {
                // Realm delete methods
                do {
                    try self.realm.write {
                        self.realm.delete(articleToDelete)
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                        completionHandler(true)
                    }
                } catch {
                    print("Error deleting article: \(error)")
                    completionHandler(false)
                }
            }
        }
        
        action.image = UIImage(systemName: "trash.fill")
        action.backgroundColor = UIColor.red
        
        return action
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.bookmarksToArticle else {
            return
        }
           
        if let articleVC = segue.destination as? ArticleViewController {
            if let articles = articles, let indexPath = sender as? IndexPath {
                articleVC.article = articles[indexPath.row]
            }
        }
    }
}
