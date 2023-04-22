//
//  ToolBarViewController.swift
//  MyBible
//
//  Created by 구태호 on 2023/04/13.
//

import UIKit
import SnapKit


class ToolBarViewController: UIViewController {
    @IBOutlet var parentViewForIB: UIView!
    // MARK: 스토리보드로 생성된 뷰의 경우 layer 가 항상 위를 덮는 문제가 발생함... 소스 코드로 생성
    var childViewForIB: UIView!
    @IBOutlet var lbChildViewForIB: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: viewDidLoad() 에서는 모든 제약조건이 설정되지 않은 상태이기 때문에, 뷰의 사이즈가 이상하게 표시됨.
        view.layoutIfNeeded()
        makeSubLayerProgrammatically()
        makeSubLayerForIB()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    
    /// 소스 코드로 뷰 및 레이어 생성
    /// - note: 자식 뷰 CALayer 테스트
    /// - note: 서브 클래싱 하지 않고 만드려면 아래 코드 확인
    /// - warning: 만약, 반복적으로 호출되는 메소드라면 반드시 이전의 **subLayer를 제거**해줘야함!!!
    func makeSubLayerProgrammatically() {
        // MARK: UIView 가 자신의 부모 뷰에 추가된 시점을 기준으로 layer 의 순서가 결정되는 듯
        let parentView = UIView()
        parentView.backgroundColor = .colorPink
        parentView.layer.cornerRadius = 10
        
        view.addSubview(parentView)
        parentView.snp.remakeConstraints {
            $0.leading.trailing.top.equalTo(view).inset(18)
            $0.height.equalTo(80)
        }
        // MARK: 레이아웃을 다시 지정하지 않으면 레이어 적용이 안됨...
        parentView.layoutIfNeeded()
        
        let parentLayer = CALayer()
        parentLayer.borderWidth = 2
        parentLayer.borderColor = UIColor.colorBlack?.cgColor
        // MARK: 레이어는 부모 뷰의 좌표계를 기준으로 (0,0) 인 지점에서 뷰모 뷰의 크기만큼 표시되어야함
        parentLayer.frame = parentView.bounds
        parentLayer.cornerRadius = 10
        parentView.layer.addSublayer(parentLayer)
        
        /* 하위 뷰 추가 */
        let childView = UIView()
        childView.backgroundColor = .colorIndigo
        childView.layer.cornerRadius = 10
        childView.layer.borderWidth = 2
        childView.layer.borderColor = UIColor.colorBlack?.cgColor
        
        parentView.addSubview(childView)
        childView.snp.remakeConstraints {
            $0.top.equalTo(parentView.snp.top).inset(-12)
            $0.leading.equalTo(parentView.snp.leading).inset(18)
        }
        
        let lbChildView = UILabel()
        lbChildView.text = "할인"
        lbChildView.textColor = .colorWhite
        lbChildView.font = .systemFont(ofSize: 14)
        lbChildView.textAlignment = .center
        lbChildView.sizeToFit()
        childView.addSubview(lbChildView)
        lbChildView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(14)
        }
    }
    
    /// 인터페이스 빌더로 생성된 뷰 레이어 추가
    func makeSubLayerForIB() {
        // MARK: 자신의 layer 에 추가할 경우 subView 위를 덮는 문제 발생함. 아래 별도의 layer 생성 후 subLayer 추가
        /* 뷰모 뷰 레이어 추가 */
        let parentLayer = CALayer()
        parentLayer.borderWidth = 2
        parentLayer.borderColor = UIColor.colorBlack?.cgColor
        parentLayer.frame = parentViewForIB.bounds
        parentLayer.cornerRadius = 10
        parentLayer.zPosition = 0
        parentViewForIB.layer.addSublayer(parentLayer)
        
        /* 하위 뷰 추가 */
        childViewForIB = UIView()
        childViewForIB.backgroundColor = .colorPink
        childViewForIB.layer.cornerRadius = 10
        childViewForIB.layer.borderWidth = 2
        childViewForIB.layer.borderColor = UIColor.colorBlack?.cgColor
        
        parentViewForIB.addSubview(childViewForIB)
        childViewForIB.snp.remakeConstraints {
            $0.top.equalTo(parentViewForIB.snp.top).inset(-12)
            $0.leading.equalTo(parentViewForIB.snp.leading).inset(18)
        }
        
        let lbChildView = UILabel()
        lbChildView.text = "할인"
        lbChildView.textColor = .colorWhite
        lbChildView.font = .systemFont(ofSize: 14)
        lbChildView.textAlignment = .center
        lbChildView.sizeToFit()
        childViewForIB.addSubview(lbChildView)
        lbChildView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(14)
        }
    }
}
