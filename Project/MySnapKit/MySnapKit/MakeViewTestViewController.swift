//
//  MakeViewTestViewController.swift
//  MySnapKit
//
//  Created by 구태호 on 2022/10/06.
//

import UIKit
import SnapKit

class MakeViewTestViewController: UIViewController {
    private var popUpShadowView: UIView!
    private var popUpView: UIView!
    private var popUpStackView: UIStackView!
    private var popUpFirstLabel: UILabel!
    private var popUpSecondLabel: UILabel!
    private var popUpThirdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeView()
    }
    
    private func makeView() {
        popUpShadowView = UIView()
        popUpShadowView.backgroundColor = .red
        popUpView = UIView()
        popUpView.backgroundColor = .orange
        popUpStackView = UIStackView()
        popUpStackView.backgroundColor = .yellow
        popUpStackView.spacing = 20.0
        popUpStackView.axis = .vertical
        popUpStackView.distribution = .fill
        popUpFirstLabel = UILabel()
        popUpFirstLabel.backgroundColor = .green
        popUpSecondLabel = UILabel()
        popUpSecondLabel.backgroundColor = .blue
        popUpThirdLabel = UILabel()
        popUpThirdLabel.backgroundColor = .purple
        
        popUpFirstLabel.text = "상세내역보기"
        popUpSecondLabel.text = "상점보기"
        popUpThirdLabel.text = "예약내역 삭제"
        
        popUpFirstLabel.sizeToFit()
        popUpSecondLabel.sizeToFit()
        popUpThirdLabel.sizeToFit()
        
        popUpStackView.addSubview(popUpFirstLabel)
        popUpStackView.addSubview(popUpSecondLabel)
        popUpStackView.addSubview(popUpThirdLabel)
        
        popUpFirstLabel.snp.remakeConstraints {
            $0.height.equalTo(popUpFirstLabel.intrinsicContentSize.height)
        }
        popUpSecondLabel.snp.remakeConstraints {
            $0.height.equalTo(popUpSecondLabel.intrinsicContentSize.height)
        }
        popUpThirdLabel.snp.remakeConstraints {
            $0.height.equalTo(popUpThirdLabel.intrinsicContentSize.height)
        }
        
        print("\(popUpFirstLabel.frame)")
        print("\(popUpStackView.frame)")
        print("\(popUpView.frame)")
        print("\(popUpShadowView.frame)")
        popUpView.addSubview(popUpStackView)
        /* 팝업 크기와 사이즈 맞게 조정, addSubView를 통해 뷰모 뷰(popUpView)에
         자식 뷰(popUpStackView)가 추가된 상황이라면 Constraints를 조정할 수 있음 */
        
        /* 길이가 가장 긴 라벨 너비를 기준으로 UIStackView 너비 지정 */
        let stackViewWidth = popUpThirdLabel.frame.width
        let stackViewSpacings = CGFloat(popUpStackView.subviews.count - 1) * popUpStackView.spacing
        let stackViewheight = popUpFirstLabel.frame.height + popUpSecondLabel.frame.height + popUpThirdLabel.frame.height + stackViewSpacings
        
        popUpStackView.snp.makeConstraints {
            $0.top.right.bottom.left.equalTo(popUpView)
            $0.width.equalTo(stackViewWidth)
            $0.height.equalTo(stackViewheight)
        }
        popUpShadowView.addSubview(popUpView)
        /* 팝업 쉐도우 뷰의 크기에 맞게(+패딩 10) Constraints 조정*/
        popUpView.snp.makeConstraints {
            $0.top.right.bottom.left.equalTo(popUpShadowView).inset(10)
        }
        self.view.addSubview(popUpShadowView)
        popUpShadowView.snp.makeConstraints {
            $0.center.equalTo(self.view.center)
        }
        
        print("\(popUpFirstLabel.frame)")
        print("\(popUpStackView.frame)")
        print("\(popUpView.frame)")
        print("\(popUpShadowView.frame)")
    }
}
