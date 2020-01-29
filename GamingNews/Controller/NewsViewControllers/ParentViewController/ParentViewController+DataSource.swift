//
//  ParentViewController+DataSource.swift
//  GamingNews
//
//  Created by Anuar on 1/30/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import UIKit

extension ParentViewController {
    // MARK: - Table view data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalArticlesCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let articleCell = Bundle.main.loadNibNamed("ArticleCell", owner: self, options: nil)?.first as? ArticleCell else {
            return UITableViewCell()
        }
        
        // If the data for the cell is already loading show activity indicator, else configure the cell
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
}
