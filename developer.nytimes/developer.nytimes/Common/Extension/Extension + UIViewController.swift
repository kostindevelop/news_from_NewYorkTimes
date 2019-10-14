//
//  Extension + UIViewController.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 14.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String) {
           let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: buttonTitle, style: .default)
           alert.addAction(okAction)
           if #available(iOS 13.0, *) {
               alert.overrideUserInterfaceStyle = .light
           }
           present(alert, animated: true, completion: nil)
       }
       
}
