//
//  ViewController.swift
//  MyGradient
//
//  Created by 구태호 on 2022/10/13.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var bottomGradientView: UIView!
    @IBOutlet var topGradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bottomGradientView.transparentGradient(startColor: .systemRed, gradientDirection: .bottom)
        topGradientView.transparentGradient(startColor: .systemBlue, gradientDirection: .top)
    }
}

