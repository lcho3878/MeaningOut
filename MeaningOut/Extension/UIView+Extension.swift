//
//  UIView+Extension.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit

extension UIView {
    
    func makeCircle() {
        layer.cornerRadius = frame.width / 2
    }
    
    func makeUnderLine(width w: Double, color: UIColor) {
        let border = CALayer()
        let width = CGFloat(w)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
    
}
