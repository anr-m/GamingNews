//
//  ParentViewController+Delegate.swift
//  GamingNews
//
//  Created by Anuar on 1/30/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import UIKit

extension ParentViewController {
    // MARK: - Table view Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: articles[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // Swipe options
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [self.bookmarkArticle(at: indexPath)])
    }
}
