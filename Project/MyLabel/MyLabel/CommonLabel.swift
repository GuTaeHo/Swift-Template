//
//  CommonLabel.swift
//  MyLabel
//
//  Created by 구태호 on 2023/07/04.
//

import UIKit

@IBDesignable
class CommonLabel: UILabel {
    private var _characterSpacing = 0.5
    
    @IBInspectable
    var characterSpacing: Double {
        get {
            return _characterSpacing
        }
        
        set {
            _characterSpacing = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        characterSpacing(_characterSpacing)
    }
}