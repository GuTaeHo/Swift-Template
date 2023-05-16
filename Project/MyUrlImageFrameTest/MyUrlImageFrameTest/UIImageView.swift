//
//  UIImageView.swift
//  MyUrlImageFrameTest
//
//  Created by 구태호 on 2023/05/16.
//

import UIKit
import Kingfisher

extension UIImageView {
    /// URL String 형식 주소를 이미지로 변환
    /// - parameter url: 표시할 이미지에 해당하는 URL
    /// - parameter completion: 이미지 로딩 완료 후 호출됨 (return: UIImage?)
    func urlImage(url: String, completion: ((UIImage?) -> Void)? = nil) {
        let url = URL(string: url)
        self.kf.indicatorType = .none
        self.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil) { result in
            // 이미지 설정 후 결과로 UIImage 반환
            switch result {
            case .success(let value):
                completion?(value.image)
            case .failure:
                completion?(nil)
            }
        }
    }
}
