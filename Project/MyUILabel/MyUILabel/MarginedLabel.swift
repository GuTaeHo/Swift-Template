//
//  MarginedLabel.swift
//  MyUILabel
//
//  Created by 구태호 on 8/24/24.
//

import UIKit


class MarginedLabel: UILabel {
    
    override var intrinsicContentSize: CGSize {
        let width = self.intrinsicContentSize.width + 18
        let height = self.intrinsicContentSize.height + 12
        return .init(width: width, height: height)
    }
}
