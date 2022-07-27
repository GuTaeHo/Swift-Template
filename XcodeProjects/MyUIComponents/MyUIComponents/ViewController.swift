//
//  ViewController.swift
//  MyUIComponents
//
//  Created by 구태호 on 2022/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cocobeanView: CocobeanTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 점 인디케이터
        self.initIndicator()
        // 애플 인디케이터
        // self.showDefaultIndicator()
//
//        let textField = CocobeanTextField(frame: CGRect(origin: CGPoint(x: 12, y: 256), size: CGSize(width: view.frame.width, height: 48)))
//        textField.onButton(buttonImage: "imgSearch") {
//            print("버튼 클릭됨")
//        }
//
//        self.view.addSubview(textField)
        
        cocobeanView.setOnButtonClickListener(buttonImage: "") {
            // 버튼 클릭 시 호출될 함수 정의
            print("imgSearch Clicked")
        }
    }
}

