//
//  ViewController.swift
//  MyUIComponents
//
//  Created by 구태호 on 2022/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cocobeanView: CocobeanTextField!
    @IBOutlet weak var btMovePageControl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 점 인디케이터
        self.initIndicator()
        // 애플 인디케이터
        // self.showDefaultIndicator()
        
        cocobeanView.onClickListener = {
            print("button clicked!!!")
        }
    }
    
    // tag 로 액션 분기
    @IBAction func haptic(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            HapticUtil.prepare(type: .NOTIFICATION, style: .LIGHT)
            break
        case 1:
            HapticUtil.prepare(type: .NOTIFICATION, style: .MEDIUM)
            break
        case 2:
            HapticUtil.prepare(type: .NOTIFICATION, style: .HEAVY)
            break
        case 3:
            HapticUtil.prepare(type: .IMPACT, style: .LIGHT)
            break
        case 4:
            HapticUtil.prepare(type: .IMPACT, style: .MEDIUM)
            break
        case 5:
            HapticUtil.prepare(type: .IMPACT, style: .HEAVY)
            break
        default:
            break
        }
    }
}

