//
//  Package.swift
//  MySkeletonView
//
//  Created by 구태호 on 2022/11/09.
//

import UIKit

struct Package: Codable {
    var thumbnail: String?
    var title: String?
    var subTitle: String?
    
    init(thumbnail: String? = nil, title: String? = nil, subTitle: String? = nil) {
        self.thumbnail = thumbnail
        self.title = title
        self.subTitle = subTitle
    }
}
