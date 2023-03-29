//
//  CommonSlider.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/25.
//

import UIKit

@IBDesignable
class CommonSlider: UISlider {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func draw(_ rect: CGRect) {
        initValue()
        initLayout()
    }
    
    func initValue() {
        minimumValue = 0
        maximumValue = 100
    }
    
    func initLayout() {
        minimumTrackTintColor = .colorPink
        maximumTrackTintColor = .systemGray
        thumbTintColor = .systemGray
        minimumValueImage = UIImage(systemName: "speaker.fill")
        maximumValueImage = UIImage(systemName: "speaker.2.fill")
        

        let trackHeight: CGFloat = 4.0
        let trackRect = CGRect(x: 0, y: (bounds.height - trackHeight) / 2.0, width: bounds.width, height: trackHeight)
        self.trackRect(forBounds: trackRect)
        
        self.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let volume = sender.value // 슬라이더의 값을 가져옴
    }
}
