//
//  KeyboardExtensionTextViewController.swift
//  MyKeyboardNotification
//
//  Created by 구태호 on 2022/12/09.
//

import UIKit

class KeyboardExtensionTextViewController: UIViewController {
    @IBOutlet var tfDummy: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardObserver(show: #selector(showKeyboard), hide: #selector(hideKeyboard))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver()
    }
    
    @objc func showKeyboard(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            tfDummy.translatesAutoresizingMaskIntoConstraints = false
            tfDummy.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardHeight).isActive = true
            tfDummy.layoutIfNeeded()
        }
    }
    
    @objc func hideKeyboard(_ notification: Notification) {
        
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
