//
//  ProfileImage.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/15/24.
//

import UIKit

struct ProfileImage {
    static let profileImages = (0...11).compactMap { UIImage(named: "profile_\($0)") }
}
