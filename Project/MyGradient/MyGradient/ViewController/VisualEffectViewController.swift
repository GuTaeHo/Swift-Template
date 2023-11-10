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
        
        // 뷰 계층 출력
        let vibrancyView = blurView.contentView.subviews.first as! UIVisualEffectView
        vibrancyView.contentView.subviews.forEach({ print($0) })
        
        blurView.layer.cornerRadius = blurView.frame.height / 8
        
    }
}
