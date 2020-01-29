//
//  BookmarksViewController+DataSource.swift
//  GamingNews
//
//  Created by Anuar on 1/30/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import UIKit

extension BookmarksViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let articleCell = Bundle.main.loadNibNamed("ArticleCell", owner: self, options: nil)?.first as? ArticleCell else {
            return UITableViewCell()
        }
        
        guard let articles = articles else {
            return UITableViewCell()
        }
        
        articleCell.configure(with: articles[indexPath.row])
        
        return articleCell
    }
}
