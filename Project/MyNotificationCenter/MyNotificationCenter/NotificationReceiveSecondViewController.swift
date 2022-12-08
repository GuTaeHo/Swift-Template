//
//  NotificationReceiveSecondViewController.swift
//  MyNotificationCenter
//
//  Created by 구태호 on 2022/11/28.
//

import UIKit

class NotificationReceiveSecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰 컨트롤러가 사라질 때 해당 Notification 을 제거하지 않고 다른 뷰 컨트롤러에서 post() 하면 어떻게 될까...?
        // MARK: 해당 뷰 컨트롤러가 완전히 제거(deinit) 되었다면 post() 를 해도 메소드가 호출되지 않음
        NotificationCenter.default.addObserver(self, selector: #selector(methodCallTest), name: .methodCallTest, object: nil)
    }
    
    @objc func methodCallTest() {
        print("NotificationReceiveSecondViewController.methodCallTest CALLED")
    }
    
    @IBAction func methodCheck(_ sender: Any) {
        NotificationCenter.default.post(name: .methodCallTest, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("NotificationReceiveSecondViewController viewDidDisappear")
    }
    
    deinit {
        print("NotificationReceiveSecondViewController deinit")
    }
}

