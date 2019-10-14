//
//  UIImageView.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 10.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit
import Foundation

let imageCache = NSCache<AnyObject, AnyObject>()

class CacheImageView: UIImageView {

    var imageUrlString: String?
    
    func downloadImage(from urlString: String, activity: UIActivityIndicatorView?) {
        if urlString != "" {
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        activity?.startAnimating()
        image = nil
        
            if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
                DispatchQueue.main.async {
                    activity?.stopAnimating()
                    activity?.isHidden = true
                    self.image = cachedImage
                    return
                }
            }
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        if let downloadedImage = UIImage(data: data!) {
                            
                            if self.imageUrlString == urlString {
                                self.image = downloadedImage
                            }
                            
                            imageCache.setObject(downloadedImage, forKey: url as AnyObject)
                            activity?.stopAnimating()
                            activity?.isHidden = true
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
