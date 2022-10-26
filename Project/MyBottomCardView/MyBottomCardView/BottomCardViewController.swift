//
//  BottomCardViewController.swift
//  MyBottomCardView
//
//  Created by 구태호 on 2022/10/26.
//

import UIKit
import SnapKit

class BottomCardViewController: UIViewController {
    @IBOutlet var containerStackView: UIStackView!
    @IBOutlet var handleView: UIView!
    @IBOutlet var handleKnobView: UIView!
    @IBOutlet var containerView: UIView!
    
    public var isHandleVisible: Bool?
    /// 사용자가 제스쳐를 진행 중 인지 검사
    private var isTouching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        initAction()
    }
    
    private func initLayout() {
        if isHandleVisible == true {
            handleView.isHidden = false
        } else {
            handleView.isHidden = true
        }
        
        handleKnobView.layer.cornerRadius = handleKnobView.frame.height / 2
    }
    
    private func initAction() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanning))
        panGesture.maximumNumberOfTouches = 1
        handleView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanning(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        
        // sender의 view는 sender가 바라보고 있는 circleView이다. 드래그로 이동한 만큼 circleView를 이동시킨다.
        let containerHeight = containerStackView.frame.height - (translation.y)
        print(containerHeight)
        // 카드뷰 최대 사이즈
        let containerMaxHeight = self.view.frame.height - 64

        // 카드뷰가 일정크기보다 크면 호출 (위로 스와이프)
        if translation.y < 0 && containerHeight > containerMaxHeight {
            return
        }
        
        containerView.snp.remakeConstraints {
            $0.height.equalTo(containerHeight)
        }
        
        // translation 초기화
        sender.setTranslation(.zero, in: self.view)
        
        // 제스처 종료 후 호출
        if sender.state == .ended {
            let containerViewHeight = containerView.frame.height
            let minimumContainerHeight = view.frame.height / 4
            
            // 카드뷰 최소 사이즈
            let containerMinHeight = view.frame.height / 4
            
            // 카드뷰가 일정크기보다 크면 호출
            if containerViewHeight > containerMaxHeight - 120 {
                UIView.animate(withDuration: 0.2) {
                    self.containerView.snp.remakeConstraints {
                        $0.height.equalTo(containerMaxHeight)
                    }
                }
                return
            }
            
            // 카드뷰가 일정크기보다 작으면 호출
            if containerViewHeight < containerMinHeight {
                self.dismiss(animated: true)
                return
            }
        }
    }
}
