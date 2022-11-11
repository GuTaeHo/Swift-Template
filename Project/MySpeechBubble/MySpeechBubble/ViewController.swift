//
//  ViewController.swift
//  MySpeechBubble
//
//  Created by 구태호 on 2022/10/05.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    // 유틸아님(직접 좌표를 지정해서 사용)
    @IBOutlet var speechBubbleForGuildLinkView: UIView!
    private var speechBubbleWidth: CGFloat!
    
    private var speechBubble: SpeechBubble!
    private var speechBubbleForGuildLink: SpeechBubbleForGuildLink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        speechBubble = SpeechBubble(
            message: "Hello, World!",
            color: UIColor(red: 0.1137, green: 0.1216, blue: 0.2, alpha: 1),
            parentView: self.view,
            centerDirection: .BOTTOM)
        
        
        speechBubbleForGuildLink = SpeechBubbleForGuildLink(message: "버블 꼬리 위치 변경 중... \n가나다라마바사아자차카타파하", color: UIColor(red: 0.1137, green: 0.1216, blue: 0.2, alpha: 1), parentView: self.speechBubbleForGuildLinkView)
    }
}

