//
//  ArticleViewController.swift
//  GamingNews
//
//  Created by Anuar on 1/28/20.
//  Copyright © 2020 Anuarbek Mukhanov. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    var article: ArticleElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    private func setUp() {
        
        var info = ""
        
        if let article = article {
            titleLabel.text = article.getTitle()
            descriptionLabel.text = article.getDescription()
            info += "Date: " + article.getDate() + "\n"
            info += "Author: " + (article.getAuthor() ?? "No author") + "\n"
            contentLabel.text = article.getContent() ?? "No content for this article"
        }
        
        if let article = article as? Article {
            if let url = URL(string: article.urlToImage) {
                imageView.kf.setImage(with: url)
            }
            info += "Source: " + article.source.name
        } else if let article = article as? ArticleCached {
            imageView.image = UIImage(data: article.imageData)
            info += "Source: " + article.source
        }
        infoLabel.text = info
    }
}
