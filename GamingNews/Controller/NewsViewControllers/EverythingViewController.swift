//
//  EverythingViewController.swift
//  GamingNews
//
//  Created by Anuar on 1/28/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import UIKit
import RealmSwift

class EverythingViewController: ParentViewController {
    
    override var url: String {
        return Constants.everythingURL
    }
    override var segueIdentifier: String {
        return Constants.everythingToArticle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        getNews()
    }
    
    @objc func refresh() {
        refreshControl?.endRefreshing()
        currentPage = 1
        getNews()
    }
}
