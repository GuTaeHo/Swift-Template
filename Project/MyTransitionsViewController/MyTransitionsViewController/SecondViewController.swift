//
//  SecondViewController.swift
//  MyTransitionsViewController
//
//  Created by 구태호 on 2023/08/27.
//

import UIKit


class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func transition(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
