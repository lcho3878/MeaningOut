//
//  UITableViewCell+Extension.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit

extension UITableViewCell: Reusable {
    
    static var id: String {
        return String(describing: self)
    }
    
}
