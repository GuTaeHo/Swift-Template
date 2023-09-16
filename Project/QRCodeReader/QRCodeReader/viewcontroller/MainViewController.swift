//
//  MainViewController.swift
//  QRCodeReader
//
//  Created by 구태호 on 2023/09/09.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    lazy var scrollView: UIScrollView = .init().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var stackViewInScrollView: UIStackView = .init().then {
        $0.axis = .vertical
        $0.isLayoutMarginsRelativeArrangement = true
        $0.spacing = 12
        $0.directionalLayoutMargins = .init(top: 12, leading: 18, bottom: 12, trailing: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var button: UIButton = .init().then {
        $0.configuration = .filled()
        var attributedString = AttributedString("QR 코드 인식")
        attributedString.font = .boldSystemFont(ofSize: 24)
        $0.configuration?.attributedTitle = attributedString
        $0.configuration?.imagePadding = 12.0
        $0.configuration?.baseBackgroundColor = .systemIndigo
        $0.configuration?.baseForegroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    /// 카메라 접근 허용 여부 반환
    var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            // Determine if the user previously authorized camera access.
            var isAuthorized = status == .authorized
            
            // If the system hasn't determined the user's authorization status,
            // explicitly prompt them for approval.
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        initAction()
    }
    
    func initLayout() {
        view.addSubview(scrollView)
        view.addSubview(button)
        scrollView.addSubview(stackViewInScrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: button.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            button.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -12),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            stackViewInScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackViewInScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackViewInScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackViewInScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            // MARK: 수직 스크롤 활성화를 위해 width 를 스택뷰 사이즈와 동일하게 설정
            stackViewInScrollView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func initAction() {
        button.configurationUpdateHandler = { [weak self] button in
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] granted in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if granted == true {
                        if button.state == .highlighted {
                            button.configuration?.showsActivityIndicator = true
                            button.configuration?.title = ""
                            button.configuration?.baseBackgroundColor = .lightGray
                            button.configuration?.baseForegroundColor = .gray
                            
                            let qrScannerVC = QRScannerViewController()
                            qrScannerVC.isModalInPresentation = true
                            qrScannerVC.presentationController?.delegate = self
                            self.navigationController?.present(qrScannerVC, animated: true)
                        }
                    } else {
                        let alert = UIAlertController(title: "카메라 접근 거부됨", message: "카메라 접근 권한을 허용해주세요.", preferredStyle: .alert)
                        
                        // 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
                        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
                        let submitAction =  UIAlertAction(title: "설정", style: UIAlertAction.Style.destructive) { _ in
                            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                            
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }

                        // 메시지 창 컨트롤러에 버튼 액션을 추가
                        alert.addAction(cancelAction)
                        alert.addAction(submitAction)

                        self.present(alert, animated: false)
                        return
                    }
                }
            })
        }
    }
}

extension MainViewController: UIAdaptivePresentationControllerDelegate {
    // pageSheet 형태로 표시된 뷰 컨트롤러가 dismiss 될 경우 호출
    // MARK: 단, isModelInPresentation 이 true 일 경우에만 동작
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        button.configuration?.showsActivityIndicator = false
        button.configuration?.baseBackgroundColor = .systemIndigo
        button.configuration?.baseForegroundColor = .white
        var attributedString = AttributedString("QR 코드 인식")
        button.configuration?.attributedTitle = attributedString
        button.configuration?.attributedTitle?.font = .boldSystemFont(ofSize: 24)
        presentationController.presentedViewController.dismiss(animated: true)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

