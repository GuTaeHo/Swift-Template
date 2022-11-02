//
//  DeviceViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class DeviceViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func next(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
