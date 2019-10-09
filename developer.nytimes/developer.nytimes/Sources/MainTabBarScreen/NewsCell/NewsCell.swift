//
//  NewsCell.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 09.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    @IBOutlet weak private var imgNews: UIImageView!
    @IBOutlet weak private var lbNewsTitle: UILabel!
    @IBOutlet weak private var lbNewsDescription: UILabel!
    @IBOutlet weak private var lbNewsDay: UILabel!
    @IBOutlet weak private var lbNewsMonth: UILabel!
    @IBOutlet weak private var btFavourites: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configuredCellWith(news: Result) {
        lbNewsTitle.text = news.title
        lbNewsDescription.text = news.abstract
    }
    
    @IBAction func didTabAddNewsToFavouritesButton(_ sender: UIButton) {
        // TODO - Add news to favourites
        print("didTabAddNewsToFavouritesButton")
    }

}
