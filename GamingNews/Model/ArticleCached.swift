//
//  ArticleCached.swift
//  GamingNews
//
//  Created by Anuar on 1/29/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import Foundation
import RealmSwift

class ArticleCached: Object {
    
    @objc dynamic var source = ""
    @objc dynamic var author: String?
    @objc dynamic var title = ""
    @objc dynamic var descriptionText = ""
    @objc dynamic var imageData = Data()
    @objc dynamic var publishedAt = ""
    @objc dynamic var content: String?
    
    override class func primaryKey() -> String? {
        return "title"
    }
    
    convenience init(article: Article) {
        self.init()
        self.source = article.source.name
        self.author = article.author
        self.title = article.title
        self.descriptionText = article.description
        self.publishedAt = article.publishedAt
        self.content = article.content
    }
}

extension ArticleCached: ArticleElement {
    func getTitle() -> String {
        return title
    }
    
    func getAuthor() -> String? {
        return author
    }
    
    func getContent() -> String? {
        return content
    }
    
    func getDescription() -> String {
        return descriptionText
    }
    
    func getDate() -> String {
        return publishedAt.components(separatedBy: "T")[0]
    }
}
