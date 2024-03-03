//
//  FirstViewController.swift
//  MyUIResponder
//
//  Created by 구태호 on 3/4/24.
//

import UIKit


class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("FirstViewController Responder Test: \(self.navigationController == self.next)")
    }
}
