//
//  ViewController.swift
//  MyToast
//
//  Created by 구태호 on 2023/03/07.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet var btToast: UIButton!
    @IBOutlet var btSnackbar: UIButton!
    @IBOutlet var tfMessage: UITextField!
    
    private var keyboardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObserver(show: #selector(keyboardShow), hide: #selector(keyboardDismiss))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObserver()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func snackbarButtonClicked(_ sender: UIButton) {
        
    }
    
    /// 토스트 표시
    @IBAction func toastButtonClicked(_ sender: UIButton) {
        let message = (tfMessage.text == "") ? "입력란 공백" : tfMessage.text!
        showToast(message: message)
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.btToast.showIndicator()
            self?.view.layoutIfNeeded()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.btToast.hideIndicator()
                self?.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.keyboardHeight = keyboardFrame.cgRectValue.height
            print(keyboardHeight)
            viewControllerMoveToAboveKeyboard()
        }
    }
    
    @objc func keyboardDismiss(notification: Notification) {
        self.keyboardHeight = 0
        viewControllerMoveToAboveKeyboard()
    }
    
    func viewControllerMoveToAboveKeyboard() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraints = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardHeight)
        bottomConstraints.priority = UILayoutPriority(500)
        bottomConstraints.isActive = true
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}

