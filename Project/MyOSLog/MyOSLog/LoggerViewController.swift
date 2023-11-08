//
//  LoggerViewController.swift
//  MyOSLog
//
//  Created by 구태호 on 11/8/23.
//

import UIKit
import OSLog


class LoggerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonHandler(_ sender: UIButton) {
        os_log("UIButton 정보: %@", log: .ui, sender)
    }
    
    @IBAction func rootViewHandler(_ sender: UIButton) {
        // os_log("안녕 MyOsLog!", type: .error)
        os_log("RootView 정보: %@", log: .network, view)
    }
    
    @IBAction func viewWindowRootVCHandler(_ sender: UIButton) {
        // os_log("안녕 MyOsLog!", type: .fault)
        os_log("현재 뷰 컨트롤러: %@", log: .deinit, view.window?.rootViewController ?? 0)
    }
}

