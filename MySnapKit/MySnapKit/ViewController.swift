//
//  ViewController.swift
//  MySnapKit
//
//  Created by 구태호 on 2022/07/11.
//

import UIKit
import SnapKit

// Interface Builder 로 지정한 제약조건은 소스 코드로는 해제되지 않는듯
// NSLayoutConstraint.deactivate() 메서드를 사용하면 뷰에 설정된 제약조건이
// 삭제된다고 하지만 예제에 적용해본 결과 안되는 것 같음
class ViewController: UIViewController {
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var lbCart: UILabel!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var greenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButton()
        initTestView()
    }
    
    private func initButton() {
        if DeviceManager.shared.isXSeries() {
            initButtonLayout(height: 88, topPadding: 0)
        } else {
            initButtonLayout(height: 56, topPadding: 0)
        }
    }
    
    private func initButtonLayout(height: Int, topPadding: Int) {
        lbCart.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            self.setCenterY(height: height)
        }
        
        cartView.snp.makeConstraints { view in
            view.height.equalTo(height)
            view.centerX.equalToSuperview()
            self.setCenterY(height: height)
        }
    }
    
    private func setCenterY(height: Int) {
        let bottomSafeAreaSize = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        
        let realHeight = CGFloat(height) - bottomSafeAreaSize
        print("[Log] realHeight \(realHeight)")
        
        print("[Log] realHeight / 2 \(realHeight / 2)")
        print("[Log] bCart.frame.height / 2 \(lbCart.frame.height / 2)")
        let topPadding = realHeight / 2 - lbCart.frame.height / 2
        print("[Log] topPadding \(topPadding)")
        
        lbCart.snp.makeConstraints() { view in
            view.top.equalTo(cartView.snp.top).inset(topPadding)
        }
    }
    
    private func initTestView() {
        blueView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(30)
        }
    }
}

