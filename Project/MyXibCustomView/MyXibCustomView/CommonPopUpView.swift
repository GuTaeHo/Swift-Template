//
//  CommonPopUpView.swift
//  MyXibCustomView
//
//  Created by 구태호 on 2023/07/23.
//

import UIKit


class CommonPopUpView: UIView {
    @IBOutlet var contentStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        unarchive()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        unarchive()
    }
    
    private func unarchive() {
        let view = Bundle.main.loadNibNamed(CommonPopUpView.className,
                                            owner: self,
                                            options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
        
        initAction()
    }
    
    func initAction() {
        let gesture = UIGestureRecognizer(target: self, action: #selector(popUpClick))
        contentStackView.addGestureRecognizer(gesture)
    }
    
    @objc func popUpClick() {
        
    }
    
    // MARK: 외부 영역 클릭 이벤트 처리
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchedView = touches.first?.view
        
        if let view = touchedView, view == subviews.first {
            removeFromSuperview()
        }
    }
}
