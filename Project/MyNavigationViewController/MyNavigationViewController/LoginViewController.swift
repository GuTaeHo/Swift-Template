//
//  LoginViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func next(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "DeviceViewController") {
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            print("뷰 컨트롤러 추가 오류...")
        }
    }
}