//
//  ColorChangableImageView.swift
//  MyUIImage
//
//  Created by 구태호 on 11/5/23.
//

import UIKit


class ColorChangableImageView: UIImageView {
    private var _image: UIImage?
    private var _tintColor: UIColor?
    
    
    init(image _image: UIImage? = nil, tintColor _tintColor: UIColor? = nil) {
        self._image = _image?.withRenderingMode(.alwaysTemplate)
        self._tintColor = _tintColor
        super.init(frame: .zero)
        setNeedsDisplay()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var image: UIImage? {
        didSet {
            _tintColor = self.tintColor
            tintColor = nil
            tintColor = _tintColor
            setNeedsDisplay()
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            _tintColor = tintColor
            setNeedsDisplay()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        image = _image
        tintColor = _tintColor
    }
}
