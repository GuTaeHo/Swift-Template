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
    
    private var keyboardHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDismiss), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.keyboardHeight = keyboardFrame.cgRectValue.height
            self.lbDisplay.text = "\(keyboardHeight!)"
        }
    }
    
    @objc func keyboardDismiss(notification: Notification) {
        self.keyboardHeight = 0
        self.lbDisplay.text = "\(keyboardHeight!)"
    }
    
    @IBAction func onClickKeyboardShow(_ sender: UIButton) {
        self.view.endEditing(true)
    }
}

