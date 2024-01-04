//
//  ViewController.swift
//  MyAutoresizingMask
//
//  Created by 구태호 on 1/4/24.
//

import UIKit


/**
 `AutoresizingMask` 는 AutoLayout 이 도입되기 이전 동적인 UI를 구성하기 위해 고안된 레이아웃 시스템이다.
 `AutoresizingMask` 는 부모뷰의 `bounds` 가 조정될 때 어떻게 자식 뷰가 표시될 것인지 조정할 수 있다.
 자식 뷰에 지정가능한 옵션은 6가지로 다음과 같다,
    1. `flexibleWidth`: 너비가 동적으로 늘어남.
    2. `.flexibleHeight`: 높이가 동적으로 늘어남.
    3. `.flexibleLeftMargin`: 좌측이 동적으로 늘어남.
    4. `.flexibleRightMargin`: 우측이 동적으로 늘어남.
    5. `.flexibleTopMargin`: 상단이 동적으로 늘어남.
    6. `.flexibleBottomMargin`: 하단이 동적으로 늘어남.
 
 위 옵션들을 사용하면 UIView 를 초기화하는 시점에 설정된 `frame`이 사용되지않는다.
 - 주의 -
 `Interface Builder` 로 UI 를 구성할 때, AutoLayout을 사용할 경우 자동으로 비활성화되지만, 코드로 UI 를 구성할 때는
 자동으로 비활성화되지 않기 때문에 익숙하게 봤을 `translatesAutoresizingMaskIntoConstraints` 옵션을 `false` 로
 지정하여 `AutoresizingMask` 을 사용하지 않겠다고 시스템에 알려야 한다.
 */
class ViewController: UIViewController {
    lazy var superView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    lazy var subView: UIView = {
        let view = UIView(frame: CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 100, height: 100)))
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(superView)
        superView.center = view.center
        superView.addSubview(subView)
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        UIView.animate(withDuration: 1.5) {
            self.superView.bounds.size = CGSize(width: 300, height: 300)
        }
    }
}

