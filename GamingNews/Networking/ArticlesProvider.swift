//
//  ArticlesProvider.swift
//  GamingNews
//
//  Created by Anuar on 1/28/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import Foundation
import Alamofire

struct ArticlesProvider {
        
    static func get(url: String, page: Int, _ completion: @escaping (SearchResult)->Void) {
        
        let searchUrl = url+"&page="+String(page)
                
        guard let url = URL(string: searchUrl) else {
            return
        }
        
        Alamofire.request(url, headers: ["Authorization": Constants.apiKey]).responseData { (response) in
            
            if let data = response.data {
                do {
                    let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                    completion(searchResult)
                } catch {
                    print(error)
                }
            }
        }
    }
}
