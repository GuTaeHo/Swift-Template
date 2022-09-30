//
//  NotificationSendViewController.swift
//  MyNotificationCenter
//
//  Created by 구태호 on 2022/09/29.
//

import UIKit

class NotificationSendViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickSendButton(_ sender: UIButton) {
        let text = textField.text ?? "입력된 값 없음"
        
        /// 5초 후 동작
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            let userInfo: [AnyHashable:Any] = ["text": text]
            
            // 해당 이름에 text를 실어서 방송
            NotificationCenter.default.post(name: .NOTIFICATION_NAME, object: nil, userInfo: userInfo)
        }
    }
}

