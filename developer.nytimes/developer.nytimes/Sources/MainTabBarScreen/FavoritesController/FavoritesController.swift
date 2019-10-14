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
    
    private var collectionView: UICollectionView?
    private var labelNoFavorites = UILabel()
    
    private var favoritesNews: [News] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuredUI()
        registeredCollectionCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    private func configuredUI() {
        labelNoFavorites.frame = view.frame
        labelNoFavorites.textAlignment = .center
        labelNoFavorites.text = "No Featured News"
        labelNoFavorites.backgroundColor = .white
        labelNoFavorites.textColor = .black
        labelNoFavorites.font = UIFont.boldSystemFont(ofSize: 22)
        view.addSubview(labelNoFavorites)
        
        let flowLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
    }
    
    private func registeredCollectionCell() {
        collectionView?.register(UINib(nibName: newsCellIdentifire, bundle: nil), forCellWithReuseIdentifier: newsCellIdentifire)
    }
    
    private func reloadData() {
        favoritesNews = StorageService.shared.getAllFavoritesNews()
        labelNoFavorites.isHidden = !favoritesNews.isEmpty
        collectionView?.isHidden = favoritesNews.isEmpty
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
        newsCell?.buttonAction = { sender in
            StorageService.shared.delete(object: favoritNews)
            self.reloadData()
            self.showAlert(title: "Ok!", message: "News removed from favorites", buttonTitle: "ОК")
        }
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
