//
//  UIStackView+.swift
//  MyLayoutGuides
//
//  Created by 구태호 on 2023/08/12.
//

import UIKit

/**
    arranged 된 서브뷰를 스택뷰 내부에서 제거할 때 removeArrangedSubview() 를 사용하면된다.
    removeArrangedSubview() 는 UI는 제거되지만, 실제로 스택 뷰 계층에서는 사라지지 않고 남아있는 것을 볼 수 있는데
    이를 해결하기 위해서 removeFromSuperView() 메소드를 사용하여 뷰 계층에서 완전히 지워줘야한다.
 `단, subView 에서 removeFromSuperView() 사용 시 removeArrangedSubview() 사용할 필요 없음`
*/
extension UIStackView {
    /// view 를 스택 뷰에서 제거
    func removeSubView(view: UIView?) {
        guard let view = view else { return }
        
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    /// 스택 뷰 하위 모든 뷰 제거
    func removeAllSubViews() {
        arrangedSubviews.forEach { (view) in
            removeSubView(view: view)
        }
    }
}
