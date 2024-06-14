//
//  Date+Extension.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import Foundation

extension Date {
    
    func dateString(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }
    
}
