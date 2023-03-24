//
//  ViewController.swift
//  MyRegex
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tfTest: CommonTextFieldView!
    
    @IBOutlet var btPhoneNumber: UIButton!
    @IBOutlet var btEmail: UIButton!
    @IBOutlet var btPassword: UIButton!
    @IBOutlet var btBusinessNumber: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        initAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tfTest.tfMessage.becomeFirstResponder()
    }
    
    func initAction() {
        tfTest.textFieldEditingChangedClosure = { [self] in
            guard let testMessage = tfTest.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                return
            }
            
            if RegExUtil.isPhoneNumber(phoneNumber: testMessage) {
                btPhoneNumber.configuration?.showsActivityIndicator = false
                btPhoneNumber.isEnabled = true
            } else {
                btPhoneNumber.configuration?.showsActivityIndicator = true
                btPhoneNumber.isEnabled = false
            }
            
            if RegExUtil.isEmail(email: testMessage) {
                btEmail.configuration?.showsActivityIndicator = false
                btEmail.isEnabled = true
            } else {
                btEmail.configuration?.showsActivityIndicator = true
                btEmail.isEnabled = false
            }
            
            if RegExUtil.isPassword(password: testMessage) {
                btPassword.configuration?.showsActivityIndicator = false
                btPassword.isEnabled = true
            } else {
                btPassword.configuration?.showsActivityIndicator = true
                btPassword.isEnabled = false
            }
            
            if RegExUtil.isBusinessNumber(number: testMessage) {
                btBusinessNumber.configuration?.showsActivityIndicator = false
                btBusinessNumber.isEnabled = true
            } else {
                btBusinessNumber.configuration?.showsActivityIndicator = true
                btBusinessNumber.isEnabled = false
            }
        }
        
        tfTest.onClickKeyboardReturn = {
            self.tfTest.tfMessage.endEditing(true)
        }
    }
}


