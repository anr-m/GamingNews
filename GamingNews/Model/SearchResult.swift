//
//  SearchResult.swift
//  GamingNews
//
//  Created by Anuar on 1/28/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let code: String?
    let message: String?
    let totalResults: Int?
    let articles: [Article]?
}
