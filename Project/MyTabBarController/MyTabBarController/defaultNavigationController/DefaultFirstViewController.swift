//
//  DefaultFirstViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/12/02.
//

import UIKit

class DefaultFirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "DefaultSecondViewController") as? DefaultSecondViewController {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
