//
//  Article.swift
//  GamingNews
//
//  Created by Anuar on 1/28/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import Foundation

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let urlToImage: String
    let publishedAt: String
    let content: String?
}

extension Article: ArticleElement {
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
        return description
    }
    
    func getDate() -> String {
        return publishedAt.components(separatedBy: "T")[0]
    }
}
