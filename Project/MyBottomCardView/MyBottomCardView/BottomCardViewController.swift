//
//  BottomCardViewController.swift
//  MyBottomCardView
//
//  Created by 구태호 on 2022/10/26.
//

import UIKit
import SnapKit

/* 하단 카드뷰 제약조건 및 이벤트 설정 UIViewController */
// 각 뷰 설명
// 1. containerView: 카드 뷰 자체
// 2. handleView: 사용자가 카드뷰와 인터렉션 할 수 있는 영역
// 3. buttonContainer: 취소 및 확인 버튼 영역
// 4. contentView: 커스텀 가능한 영역 (외부에서 ContentView(frame) 형태로 주입가능)
class BottomCardViewController: UIViewController {
    /// 컨테이너 뷰
    @IBOutlet var containerView: UIView!
    /// 핸들 View
    @IBOutlet var handleView: UIView!
    @IBOutlet var handleKnobView: UIView!
    /// 버튼 컨테이너 View
    @IBOutlet var buttonContainerView: UIView!
    /// 버튼 View
    @IBOutlet var cancelView: UIView!
    @IBOutlet var lbCancel: UILabel!
    @IBOutlet var ButtonDummyView: UIView!
    @IBOutlet var submitView: UIView!
    @IBOutlet var lbSubmit: UILabel!
    /// 실질적인 내용이 들어가는 View
    @IBOutlet var contentView: UIView!
    
    /// 외부에서 주입된 ContentView
    public var customContentView: UIView!
    /// 핸들 표시 여부
    public var isHandleVisible: Bool?
    /// containerView 모서리 라운딩 값
    public var cornerRadius: CGFloat?
    
    public var isCancelButtonVisible: Bool?
    public var cancelText: String!
    public var cancelCompletion: (() -> ())?
    public var isSubmitButtonVisible: Bool?
    public var submitText: String!
    public var submitCompletion: (() -> ())?
    
    /// 최초 컨테이너 뷰 높이 (콘텐츠 사이즈에 맞는 컨테이너 높이)
    private var originalContainerViewHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requireData()
    }
    
    private func requireData() {
        guard let customContentView = customContentView else {
            print("customContentView 를 읽어올 수 없습니다")
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
            return
        }
        
        contentView.addSubview(customContentView)
        
        initLayout()
        initAction()
    }
    
    private func initLayout() {
        // 버튼 사이즈 조정
        buttonContainerView.snp.remakeConstraints {
            $0.height.equalTo(0)
        }
        cancelView.snp.remakeConstraints {
            $0.width.equalTo(0)
        }
        submitView.snp.remakeConstraints {
            $0.width.equalTo(0)
        }
        
        // 핸들뷰 표시 여부에 따라 높이 재 지정
        if isHandleVisible == true {
            handleView.snp.remakeConstraints {
                $0.height.equalTo(30)
            }
        } else {
            handleView.snp.remakeConstraints {
                $0.height.equalTo(0)
            }
        }
        
        // 버튼 컨테이너 뷰 높이 및 표시여부 재 지정
        if isCancelButtonVisible == true {
            cancelView.snp.remakeConstraints {
                $0.width.equalTo(60)
            }
            buttonContainerView.snp.remakeConstraints {
                $0.height.equalTo(50)
            }
        }
        
        if isSubmitButtonVisible == true {
            submitView.snp.remakeConstraints {
                $0.width.equalTo(60)
            }
            buttonContainerView.snp.remakeConstraints {
                $0.height.equalTo(50)
            }
        }
        
        view.layoutIfNeeded()
        // contentView 사이즈 초기화
        // 커스텀 콘텐츠 뷰의 최대크기는 핸들바 + 버튼 컨테이너 + 콘텐츠 뷰 - topSafeArea - 50 정도로 하면 될듯?
        contentView.snp.remakeConstraints {
            let handleViewHeight = handleView.frame.height
            let buttonViewHeight = buttonContainerView.frame.height
            let contentViewHeight = customContentView!.frame.height
            let cardViewHeight = handleViewHeight + buttonViewHeight + contentViewHeight
            if self.view.frame.height > cardViewHeight {
                $0.height.equalTo(contentViewHeight)
            } else {
                $0.height.equalTo(self.view.frame.height - 200)
            }
        }
        
        view.layoutIfNeeded()
        originalContainerViewHeight = containerView.frame.height
        
        print("--- layoutIfNeed() 후 ---")
        print("최초 핸들 뷰 사이즈 -> \(handleView.frame.height)")
        print("최초 버튼 스택 뷰 사이즈 -> \(buttonContainerView.frame.height)")
        print("최초 컨테이너 뷰 사이즈 -> \(containerView.frame.height)")
        print("최초 오리지널 컨테이너 뷰 사이즈 -> \(originalContainerViewHeight!)")
        print("최초 컨텐츠 뷰 사이즈 -> \(contentView.frame.height)")
        
        handleKnobView.layer.cornerRadius = handleKnobView.frame.height / 2
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = cornerRadius ?? 0
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        containerView.layer.cornerRadius = 24
        lbCancel.text = cancelText
        lbSubmit.text = submitText
        
        // X Series 이외의 기기라면 safeArea, handleViewHeight 크기만큼 뺌
        if let safeAreaBottomHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom {
            originalContainerViewHeight = originalContainerViewHeight + safeAreaBottomHeight
        }
        print("X 시리즈 오리지널 컨테이너 뷰 사이즈 -> \(originalContainerViewHeight!)")
    }
    
    private func initAction() {
        cancelView.addAction {
            self.cancelCompletion?()
            self.dismiss(animated: true)
        }
        
        submitView.addAction {
            self.submitCompletion?()
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanning))
        panGesture.maximumNumberOfTouches = 1
        handleView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanning(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        
        let changedContainerHeight = containerView.frame.height - (translation.y)
        print(changedContainerHeight)
        
        // translation 초기화
        sender.setTranslation(.zero, in: self.view)
        
        if changedContainerHeight > self.originalContainerViewHeight {
            return
        }
        
        containerView.snp.remakeConstraints {
            $0.height.equalTo(changedContainerHeight)
        }
        
        // 제스처 종료 후 호출
        if sender.state == .ended {
            let containerViewHeight = containerView.frame.height
            // 카드뷰 최소 사이즈
            let containerMinHeight = view.frame.height / 6
            
            /* Swift에서 where절을 활용하면 switch case 문 내부에서도 조건식 형태로 값을 비교할 수 있음 */
            switch changedContainerHeight {
                
                /* 카드뷰가 일정크기보다 작을때 */
            case _ where changedContainerHeight < containerMinHeight:
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, animations: {
                    self.containerView.isHidden = true
                }) { _ in
                    self.dismiss(animated: true)
                }
                return
                
                
                /* 카드뷰가 일정크기보다 클때 (사이즈 원복) */
            case _ where containerViewHeight > containerMinHeight:
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3) {
                    self.containerView.snp.updateConstraints {
                        $0.height.equalTo(self.originalContainerViewHeight)
                    }
                    // 제약조건 업데이트 후 UIView 다시 그림
                    self.view.layoutIfNeeded()
                }
                return
                
            default:
                break
            }
        }
    }
}
