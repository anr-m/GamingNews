//
//  ArticleCell.swift
//  GamingNews
//
//  Created by Anuar on 1/28/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {

    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(with article: ArticleElement) {
        
        if let article = article as? Article {
            self.titleLabel.text = article.title
            self.descriptionLabel.text = article.description
            
            if let imageURL = URL(string: article.urlToImage) {
                self.thumbnailView.kf.setImage(with: imageURL)
            }
        } else if let article = article as? ArticleCached {
            self.titleLabel.text = article.title
            self.descriptionLabel.text = article.descriptionText
            self.thumbnailView.image = UIImage(data: article.imageData)
        }
    }
    
}
