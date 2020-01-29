//
//  ArticleElement.swift
//  GamingNews
//
//  Created by Anuar on 1/30/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import Foundation

// Protocol to unify Article and ArticleCached
protocol ArticleElement {
    func getAuthor() -> String?
    func getTitle() -> String
    func getDescription() -> String
    func getDate() -> String
    func getContent() -> String?
}
