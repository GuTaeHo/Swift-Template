//
//  ViewController.swift
//  MyLottie
//
//  Created by 구태호 on 2022/12/18.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    @IBOutlet var testLottieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func showIndicator(_ sender: Any) {
        checkIndicator()
    }
}

