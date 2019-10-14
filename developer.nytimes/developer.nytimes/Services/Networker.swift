//
//  Networker.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 09.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import Foundation
import Alamofire

class Networker {
    
    private let key = "UckfmA71O5KBlz2RxnBlW2WwUcO5LLGG"
    
    func getNews(with urlParameter: String, completion: @escaping (NewsModel?) -> Void) {
        let urlString = General.baseURL + urlParameter + "?api-key=\(self.key)"
        Alamofire.request(urlString, method: .get)
            .validate()
            
            .responseData { response in
                guard response.result.isSuccess else {
                    completion(nil)
                    return
                }
                
                guard let data = response.result.value else {
                    completion(nil)
                    return
                }
                let newsModel = try? JSONDecoder().decode(NewsModel.self, from: data)
                DispatchQueue.main.async {
                    completion(newsModel)
                }
        }
    }
}


