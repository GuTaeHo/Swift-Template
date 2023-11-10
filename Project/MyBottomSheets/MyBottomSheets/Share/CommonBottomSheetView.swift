//
//  CommonBottomSheetView.swift
//  MyBottomSheets
//
//  Created by 구태호 on 11/10/23.
//

import UIKit
import Combine


class CommonBottomSheetView: UIView {
    enum Mode {
        case tip
        case middle
        case full
        case dynamic
    }
    
    private enum Const {
        static let bottomSheetRatio: (Mode) -> Double = { mode in
            switch mode {
            case .tip:
                return 0.2
            case .middle:
                return 0.5
            case .full:
                return 0.8
            default:
                // TODO: 추후 동적 변경
                return 0.5
            }
        }
        static let bottomSheetYPosition: (Mode) -> Double = { mode in
            return (1.0 - Self.bottomSheetRatio(mode)) * UIScreen.main.bounds.height
        }
    }
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        // TODO: 이니셜라이저로 받기
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.title = "뒤로가기"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private var initialView: Mode!
    private var viewTypes: [Mode]!
    private var cancellables = Set<AnyCancellable>()
    
    
    convenience init(initialView: Mode, viewTypes: [Mode]) {
        self.init(frame: .zero)
        self.initialView = initialView
        self.viewTypes = viewTypes
        initLayout()
        initAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func initLayout() {
        backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        addSubview(contentView)
        contentView.addSubview(grabberView)
        
        // TODO: 초기 표시자가 dynamic 이 아니면 초기 표시자 대로 처리해야함
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: Const.bottomSheetYPosition(initialView))
        ])
        
        // Grabber View
        NSLayoutConstraint.activate([
            grabberView.centerXAnchor.constraint(equalTo: centerXAnchor),
            grabberView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            grabberView.widthAnchor.constraint(equalToConstant: 64),
            grabberView.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        initAction()
    //
    //        // Do any additional setup after loading the view.
    //    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    //        contentView.transform = .init(translationX: 0, y: contentView.bounds.height * 0.5)
    //
    //        UIView.animate(
    //            withDuration: 0.5,
    //            delay: 0,
    //            usingSpringWithDamping: 0.8,
    //            initialSpringVelocity: 1
    //        ) {
    //            self.contentView.transform = .identity
    //        }
    //    }
    
    private func initAction() {
        throttleTapGesturePublisher().sink { [weak self] _ in
            self?.dismissScene()
        }.store(in: &cancellables)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        grabberView.addGestureRecognizer(panGesture)
    }
    
    @objc private func didPan(_ recognizer: UIPanGestureRecognizer) {
        let translationY = recognizer.translation(in: self).y
        let minY = self.contentView.frame.minY
        let offset = translationY + minY
        
        if Const.bottomSheetYPosition(.full)...Const.bottomSheetYPosition(.tip) ~= offset {
            self.updateConstraint(offset: offset)
            recognizer.setTranslation(.zero, in: contentView)
        }
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: .curveEaseOut,
            animations: self.layoutIfNeeded,
            completion: nil
        )
        
        guard recognizer.state == .ended else { return }
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .allowUserInteraction,
            animations: {
                // velocity를 이용하여 위로 스와이프인지, 아래로 스와이프인지 확인
                // self.mode = recognizer.velocity(in: self).y >= 0 ? Mode.tip : .full
            },
            completion: { _ in
                
            }
        )
    }
    
    private func dismissScene() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1) {
            self.contentView.transform = .init(translationX: 0, y: self.contentView.bounds.height)
            self.contentView.alpha = 0
            self.removeFromSuperview()
        }
    }
    
    private func updateConstraint(offset: Double) {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: offset),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        layoutIfNeeded()
    }
}
