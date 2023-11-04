//
//  ViewController.swift
//  MySnapKit
//
//  Created by 구태호 on 2022/07/11.
//

import UIKit
import SnapKit


/**
 제약조건을 변경하기 위해서는 `우선순위(priority)` 의 개념이 중요.
 우선순위가 `1000 또는 required` 로 지정되면 제약조건을 제거하는 것이 불가능(가장 높은 우선순위이기 때문) 하며,
 우선순위를 내리는 것도 불가능하다. (이 경우 레이아웃 아웃렛을 통해서 constraints 를 변경하는 방법이외엔 없는듯)
 만약, 필수적으로 변경되어야하는 제약조건이 있다면 `999` 또는 그 이하로 설정해야한다.
 */
class ViewController: UIViewController {
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    
    lazy var constraintsTestView: UIView = {
        let constraintsTestView = UIView()
        /// 자체적인 제약조건인 width, height 는 뷰가 슈퍼뷰에 `추가되기 전에 지정`해도 문제가 없다.
        constraintsTestView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        constraintsTestView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        constraintsTestView.backgroundColor = .brown
        constraintsTestView.translatesAutoresizingMaskIntoConstraints = false
        
        return constraintsTestView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 인터페이스 빌더로 설정된 제약조건을 해제하고 재설정 가능할까?
        /// 스냅킷이던, 빌트인이던 제약조건 `우선순위가 높은 쪽`이 적용(이 경우 에러로그 표시 X)되며, 서로 같다면 에러로그를 표시하고 시스템이 자동으로 제약조건을 지정한다.
        /* 스냅킷 예시 */
        greenView.snp.updateConstraints({
            $0.top.equalToSuperview()
        })
        
        // MARK: redView 의 모든 제약조건을 제거한다.
        /// 제약조건을 모두 제거하더라도, 우선순위가 `1000` 으로 할당된 제약조건이 있다면 제거되지 않으며, 제약조건이 충돌할 경우, 시스템이 둘 중 하나를 택하여 설정한다.
        NSLayoutConstraint.deactivate(redView.constraints)
        /* 빌트인 예시 */
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            redView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            redView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(constraintsTestView)
        constraintsTestView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        constraintsTestView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

