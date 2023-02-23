//
//  ViewController.swift
//  MyXibCustomView
//
//  Created by 구태호 on 2022/11/09.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 커스텀 뷰 로딩 방법
        if let customView: CocobeanView = UIView.loadFromNib() {
            view.addSubview(customView)
            // 커스텀 뷰 사이즈 지정
            customView.snp.remakeConstraints
            {
                $0.centerX.centerY.equalToSuperview()
                $0.width.equalToSuperview().inset(36)
            }
        }
    }
}

