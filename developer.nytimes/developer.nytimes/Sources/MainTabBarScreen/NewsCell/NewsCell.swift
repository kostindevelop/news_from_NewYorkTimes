//
//  NewsCell.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 09.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    @IBOutlet weak private var imgNews: CacheImageView!
    @IBOutlet weak private var lbNewsTitle: UILabel!
    @IBOutlet weak private var lbNewsDescription: UILabel!
    @IBOutlet weak private var lbNewsDay: UILabel!
    @IBOutlet weak private var lbNewsMonth: UILabel!
    @IBOutlet weak private var btFavourites: UIButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configuredUI()
    }
    
    private func configuredUI() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.8, height: 0.8)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }
    
    func configuredCellWith(news: Result) {
        lbNewsTitle.text = news.title
        lbNewsDescription.text = news.abstract
        if let imageStrin = news.media?.first?.mediaMetadata?.first?.url {
            imgNews.downloadImage(from: imageStrin, activity: activityIndicator)
        }
        
    }
    
    @IBAction func didTabAddNewsToFavouritesButton(_ sender: UIButton) {
        // TODO - Add news to favourites
        print("didTabAddNewsToFavouritesButton")
    }

}
