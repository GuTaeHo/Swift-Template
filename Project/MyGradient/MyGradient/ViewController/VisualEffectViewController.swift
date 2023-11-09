//
//  VisualEffectViewController.swift
//  MyGradient
//
//  Created by 구태호 on 11/9/23.
//

import UIKit


class VisualEffectViewController: UIViewController {
    @IBOutlet var blurView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurView.layer.cornerRadius = blurView.frame.height / 8
        
    }
}
