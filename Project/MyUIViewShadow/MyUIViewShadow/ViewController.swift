//
//  ViewController.swift
//  MyUIViewShadow
//
//  Created by 구태호 on 2022/10/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var baseView: UIView!
    @IBOutlet var innerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        innerView.shadow()
    }


}

