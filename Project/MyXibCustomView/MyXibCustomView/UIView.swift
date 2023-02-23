//
//  UIView.swift
//  MyXibCustomView
//
//  Created by 구태호 on 2023/02/17.
//

import UIKit

extension UIView {
    /// Xib 파일 로딩 시 사용
    /// - note: T
    /**
    ```
    /// 해당 메소드 인스턴스화 시
     if let customView: CustomView = UIView.loadFromNib() { do something }
    ```
     */
    static func loadFromNib<T>() -> T? {
        let identifier = String(describing: T.self)
        let view = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first
        return view as? T
    }
}
