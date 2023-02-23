//
//  BlueViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/12/01.
//

import UIKit

class BlueViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func next(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
