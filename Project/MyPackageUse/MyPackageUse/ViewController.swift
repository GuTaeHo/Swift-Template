//
//  ViewController.swift
//  MyPackageUse
//
//  Created by 구태호 on 6/4/24.
//

import UIKit
import MyPackage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        HelloWorld().printHelloWorld()
    }
}

