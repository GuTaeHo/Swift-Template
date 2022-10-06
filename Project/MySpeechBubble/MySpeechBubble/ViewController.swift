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
            message: "라벨의 텍스트가 길어지면 길어질수록, 말풍선의 크기가 커집니다.",
            color: UIColor.blue,
            parentView: self.view,
            width: self.view.frame.width / 2)
    }
}

