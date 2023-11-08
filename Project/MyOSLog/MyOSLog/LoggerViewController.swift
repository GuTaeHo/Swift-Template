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

    @IBAction func onlyMessageHandler(_ sender: UIButton) {
        os_log("UI 로그: %@", log: .ui, sender)
    }
    
    @IBAction func messageWithErrorHandler(_ sender: UIButton) {
        // os_log("안녕 MyOsLog!", type: .error)
        os_log("Network 로그: %@", log: .network, view)
    }
    
    @IBAction func messageWithFaultHandler(_ sender: UIButton) {
        // os_log("안녕 MyOsLog!", type: .fault)
        os_log("화면 스케일: %@", log: .deinit, view.window?.rootViewController ?? 0)
    }
}

