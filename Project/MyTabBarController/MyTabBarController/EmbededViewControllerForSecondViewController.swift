//
//  EmbededViewControllerForSecondViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/11/14.
//

import UIKit

class EmbededViewControllerForSecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
