//
//  ViewedController.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 10.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit
import SafariServices

private let newsCellIdentifire = "NewsCell"

class ViewedController: UIViewController {
    
    private let networker = Networker()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var newsModel: NewsModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: newsCellIdentifire, bundle: nil), forCellWithReuseIdentifier: newsCellIdentifire)
        networker.getNews(with: .viewed) { (news) in
            self.newsModel = news
        }
    }
}


//MART: - UICollectionViewDataSource

extension ViewedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsModel?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCellIdentifire, for: indexPath) as? NewsCell
        let news = (newsModel?.results?[indexPath.item])!
        newsCell?.configuredCellWith(news: news)
        return newsCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedNews = newsModel?.results?[indexPath.item] {
            if let detailNewsURLString = selectedNews.url {
                let detailNewsURL = URL(string: detailNewsURLString)!
                let safariVC = SFSafariViewController(url: detailNewsURL)
                present(safariVC, animated: true, completion: nil)
            }
        }
    }
}


//MART: - UICollectionViewDelegateFlowLayout

extension ViewedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 24
        return CGSize(width: width, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24
            , left: 24, bottom: 20, right: 24)
    }
    
}


//MART: - UICollectionViewDelegate

extension ViewedController: UICollectionViewDelegate {}

