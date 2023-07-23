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
        if let customView = UIView.loadFromNib(type: CocobeanView.self) {
            view.addSubview(customView)
            // 커스텀 뷰 사이즈 지정
            customView.snp.remakeConstraints
            {
                $0.centerX.centerY.equalToSuperview()
                $0.width.equalToSuperview().inset(36)
            }
        }
        
        // MARK: 커스텀 팝업 표시 및 제약조건 지정
        let commonPopUpView = CommonPopUpView()
        view.addSubview(commonPopUpView)
        commonPopUpView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

