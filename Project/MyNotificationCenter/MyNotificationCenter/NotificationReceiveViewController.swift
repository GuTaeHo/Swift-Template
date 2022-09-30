//
//  NotificationReceiveViewController.swift
//  MyNotificationCenter
//
//  Created by 구태호 on 2022/09/29.
//

import UIKit

class NotificationReceiveViewController: UIViewController {
    
    @IBOutlet var lbReceive: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 수신자 등록
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveText(_:)), name: .NOTIFICATION_NAME, object: nil)
    }
    
    @objc func didReceiveText(_ notification: Notification) {
        if let text = notification.userInfo?["text"] as? String {
            lbReceive.text = text
        }
    }
}
