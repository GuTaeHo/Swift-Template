//
//  ViewController.swift
//  MySpeechBubble
//
//  Created by 구태호 on 2022/10/05.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private var speechBubbleWidth: CGFloat!
    
    private var speechBubble: SpeechBubble!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        speechBubble = SpeechBubble(
            message: "Hello, World!",
            color: UIColor(red: 0.1137, green: 0.1216, blue: 0.2, alpha: 1),
            parentView: self.view,
            direction: .RIGHT,
            width: self.view.frame.width / 3)
    }
}

