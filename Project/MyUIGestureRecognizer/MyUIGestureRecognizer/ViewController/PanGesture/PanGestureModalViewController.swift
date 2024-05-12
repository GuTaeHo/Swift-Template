//
//  PanGestureModalViewController.swift
//  MyUIGestureRecognizer
//
//  Created by 구태호 on 5/13/24.
//

import UIKit
import SnapKit
import Then


class PanGestureModalViewController: UIViewController {
    var noticeLabel = UILabel().then {
        $0.text = "아래로 패닝"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .white
    }
    
    var closeButton = UIButton(configuration: .plain()).then {
        $0.configuration?.image = .init(systemName: "xmark")
        $0.configuration?.baseForegroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initLayout()
        initAction()
    }
    
    func initViews() {
        view.addSubview(noticeLabel)
        view.addSubview(closeButton)
        
        noticeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.leading.equalTo(view.snp.leading).inset(12)
        }
    }
    
    func initLayout() {
        view.backgroundColor = .black
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    func initAction() {
        closeButton.addAction { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    @objc func handleDismiss(_ sender: UIPanGestureRecognizer) {
        let viewTranslation = sender.translation(in: view)
        let viewVelocity = sender.velocity(in: view)
        
        print("viewTranslation >>> \(viewTranslation.y)")
        print("viewVelocity >>> \(viewVelocity.y)")
        
        switch sender.state {
        case .changed:
            if viewTranslation.y > 0 {
                UIView.animate(withDuration: 0.1, animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: viewTranslation.y)
                })
            }
        case .ended:
            if viewTranslation.y < (view.bounds.height / 2) {
                UIView.animate(withDuration: 0.1, animations: {
                    self.view.transform = .identity
                })
            } else {
                /// 뷰 높이의 절반 이상이라면 종료
                dismiss(animated: true, completion: nil)
            }
            
            /// 가속도가 1200 이상이라면 종료
            if viewVelocity.y > 1200 {
                dismiss(animated: true, completion: nil)
            }
            
        default:
            break
        }
    }
}
