//
//  ViewController.swift
//  MyGradient
//
//  Created by 구태호 on 2022/10/13.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        headerView.gradient()
    }


}

