//
//  ParentViewController+DataSourcePrefetching.swift
//  GamingNews
//
//  Created by Anuar on 1/30/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import UIKit

extension ParentViewController: UITableViewDataSourcePrefetching {
    // MARK: - DataSourcePrefetching for infinite scroll
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
          getNews()
        }
    }
    
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
    
    func onLoadCompleted(with newIndexPathsToReload: [IndexPath]) {
      let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
      tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
}
