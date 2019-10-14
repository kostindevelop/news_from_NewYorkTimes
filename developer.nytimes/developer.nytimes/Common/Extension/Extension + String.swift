//
//  Extension + String.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 14.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import Foundation

enum DateType {
    case Day, Month
}

extension String {
    func convertToDateString(with formatType: DateType) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        dateFormatterGet.locale = NSLocale.current
        let dateFormatterPrint = DateFormatter()
        
        switch formatType {
        case .Month:
            dateFormatterPrint.dateFormat = "MMM"
        case .Day:
            dateFormatterPrint.dateFormat = "dd"
        }
        if let date = dateFormatterGet.date(from: self) {
            let convertedString = dateFormatterPrint.string(from: date)
            return convertedString
        } else {
            print("error")
            return ""
        }
    }
}
