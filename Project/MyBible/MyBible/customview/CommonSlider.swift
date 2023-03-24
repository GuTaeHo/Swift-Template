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
        
        initValue()
        initLayout()
    }
    
    func initValue() {
        minimumValue = 0
        maximumValue = 100
    }
    
    func initLayout() {
        minimumTrackTintColor = .systemPink
        maximumTrackTintColor = .systemGray
        thumbTintColor = .white
        minimumValueImage = UIImage(systemName: "speaker.fill")
        maximumValueImage = UIImage(systemName: "speaker.2.fill")
        
        setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)

        let trackHeight: CGFloat = 4.0
        let trackRect = CGRect(x: 0, y: (bounds.height - trackHeight) / 2.0, width: bounds.width, height: trackHeight)
        self.trackRect(forBounds: trackRect)
        
        self.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let volume = sender.value // 슬라이더의 값을 가져옴
    }
}
