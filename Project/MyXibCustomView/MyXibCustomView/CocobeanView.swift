//
//  CocobeanView.swift
//  MyXibCustomView
//
//  Created by 구태호 on 2022/11/09.
//

import UIKit

class CocobeanView: UIView {
    // 소스코드에서 호출 (인스턴스 생성 시)
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    // 스토리보드에서 호출
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    func loadView() {
        let view = Bundle.main.loadNibNamed("CocobeanView", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
    }
}
