//
//  TopHeadlinesViewController.swift
//  GamingNews
//
//  Created by Anuar on 1/28/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import UIKit
import RealmSwift

class TopHeadlinesViewController: ParentViewController {
    
    var timer: Timer?
    
    override var url: String {
        return Constants.topURL
    }
    override var segueIdentifier: String {
        return Constants.topToArticle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()
        timer = Timer.scheduledTimer(withTimeInterval: Constants.timeInterval, repeats: true) { [weak self] timer in
            self?.currentPage = 1
            self?.getNews()
        }
    }
}
