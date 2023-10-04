//
//  ViewController.swift
//  MyKeyboardNotification
//
//  Created by 구태호 on 2022/08/08.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lbDisplay: UILabel!
    @IBOutlet weak var tfkeyboard: UITextField!
    @IBOutlet weak var btKeyboardShow: UIButton!
    @IBOutlet var btNextVC: UIButton!
    
    private var keyboardHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // addKeyboardObserver(show: #selector(keyboardShow), hide: #selector(keyboardDismiss))
        // iOS 15 부터 추가된 새로운 키보드 관련 API
        btNextVC.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -18).isActive = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // removeKeyboardObserver()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.keyboardHeight = keyboardFrame.cgRectValue.height
            self.lbDisplay.text = "\(keyboardHeight!)"
            UIView.animate(withDuration: 0.1, animations: {
                self.btNextVC.layoutIfNeeded()
                let constraint = self.btNextVC.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -(self.keyboardHeight! + 18))
                /// `priorty 를 999 로 설정하여 제약조건 변경 보장`
                constraint.priority = .init(rawValue: 999)
                constraint.isActive = true
            })
        }
    }
    
    @objc func keyboardDismiss(notification: Notification) {
        self.keyboardHeight = 0
        self.lbDisplay.text = "\(keyboardHeight!)"
        let constraint = self.btNextVC.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18)
        constraint.priority = .init(rawValue: 999)
        constraint.isActive = true
    }
    
    @IBAction func onClickKeyboardShow(_ sender: UIButton) {
        self.view.endEditing(true)
    }
}

