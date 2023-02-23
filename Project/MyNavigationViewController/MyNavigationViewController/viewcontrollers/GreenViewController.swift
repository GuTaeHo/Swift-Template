//
//  GreenViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class GreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func next(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func popAndPush(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "BlueViewController") as? BlueViewController {
            self.navigationController?.popToRootAndPushViewController(moveTo: viewController)
        }
    }
}
