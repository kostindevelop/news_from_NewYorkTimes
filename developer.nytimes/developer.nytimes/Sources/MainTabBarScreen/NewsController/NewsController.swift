//
//  NewsController.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 14.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit
import SafariServices

enum NewsType: String {
    case emailed = "/emailed/30.json"
    case viewed = "/viewed/30.json"
    case shared = "/shared/30/facebook.json"
}

private let newsCellIdentifire = "NewsCell"
private let emptyCellIdentifire = "EmptyCell"

class NewsController: UIViewController {
    
    private let networker = Networker()
    
    var newsType: NewsType = .emailed
    
    private var collectionView: UICollectionView?
    
    lazy var refresh: UIRefreshControl = {
        var refresh = UIRefreshControl()
        refresh.tintColor = .blue
        refresh.layer.zPosition = -1
        refresh.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        return refresh
    }()
    
    var newsModel: NewsModel? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuredUI()
        registeredCollectionViewCell()
        loadData()
    }
    
    @objc private func didRefresh() {
        networker.getNews(with: newsType.rawValue) { (news) in
            self.refresh.endRefreshing()
            guard let news = news else { return }
            self.newsModel = news
        }
    }
    
    private func loadData() {
        networker.getNews(with: newsType.rawValue) { (news) in
            self.newsModel = news
        }
    }
    
    private func configuredUI() {
        let flowLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.refreshControl = refresh
        view.addSubview(collectionView!)
    }
    
    private func registeredCollectionViewCell() {
        collectionView?.register(UINib(nibName: newsCellIdentifire, bundle: nil), forCellWithReuseIdentifier: newsCellIdentifire)
        collectionView?.register(UINib(nibName: emptyCellIdentifire, bundle: nil), forCellWithReuseIdentifier: emptyCellIdentifire)
    }
}


//MART: - UICollectionViewDataSource

extension NewsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsModel?.results?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if newsModel == nil {
            let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellIdentifire, for: indexPath)
            return emptyCell
        } else {
            let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCellIdentifire, for: indexPath) as? NewsCell
            let news = (newsModel?.results?[indexPath.item])!
            newsCell?.configuredCellWith(news: news)
            newsCell?.buttonAction = { sender in
                StorageService.shared.addNewsToFavourites(with: news)
                self.showAlert(title: "Ok!", message: "News added to favorites", buttonTitle: "ОК")
            }
            return newsCell!
        }
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

extension NewsController: UICollectionViewDelegateFlowLayout {
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

extension NewsController: UICollectionViewDelegate {}

