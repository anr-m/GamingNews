//
//  Constants.swift
//  GamingNews
//
//  Created by Anuar on 1/28/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import Foundation

enum Constants {
    static let apiKey = "cd152211e3ea4246ad902bacd89e020d"
    static let topURL = "https://newsapi.org//v2/top-headlines?q=gaming&pageSize=15"
    static let everythingURL = "https://newsapi.org//v2/everything?q=gaming&pageSize=15"
    static let topToArticle = "topToArticle"
    static let everythingToArticle = "everythingToArticle"
    static let bookmarksToArticle = "bookmarksToArticle"
    static let timeInterval = 5.0
}
