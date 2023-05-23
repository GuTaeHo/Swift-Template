//
//  ViewController.swift
//  MyIntrinsicContentSize
//
//  Created by 구태호 on 2023/05/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let customLabel = view.subviews.filter({ $0 is CustomLabel }).first
        
    }
}

