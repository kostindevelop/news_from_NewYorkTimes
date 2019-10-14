//
//  FavoritesController.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 14.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit
import SafariServices

private let newsCellIdentifire = "NewsCell"

class FavoritesController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var favoritesNews: [News] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: newsCellIdentifire, bundle: nil), forCellWithReuseIdentifier: newsCellIdentifire)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoritesNews = StorageService.shared.getAllFavoritesNews()
    }
}


//MART: - UICollectionViewDataSource

extension FavoritesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCellIdentifire, for: indexPath) as? NewsCell
        let favoritNews = favoritesNews[indexPath.row]
        newsCell?.configuredCellWith(favoritesNews: favoritNews)
        return newsCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedNews = favoritesNews[indexPath.item].detailNewsUrl {
            let detailNewsURL = URL(string: selectedNews)!
            let safariVC = SFSafariViewController(url: detailNewsURL)
            present(safariVC, animated: true, completion: nil)
        }
    }
}


//MART: - UICollectionViewDelegateFlowLayout

extension FavoritesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 24
        return CGSize(width: width, height: 115)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24
            , left: 0, bottom: 20, right: 0)
    }
    
}


//MART: - UICollectionViewDelegate

extension FavoritesController: UICollectionViewDelegate {}
