//
//  Date+Extension.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import Foundation

extension Date {
    
    private static let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
    
    func dateString(_ format: String) -> String {
        Date.dateFormatter.dateFormat = format
        let formattedDate = Date.dateFormatter.string(from: self)
        return formattedDate
    }
    
}
