//
//  SecondViewController.swift
//  MyUIResponder
//
//  Created by 구태호 on 3/4/24.
//

import UIKit


class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SecondViewController Responder Test: \(self.navigationController == self.next)")
    }
}
