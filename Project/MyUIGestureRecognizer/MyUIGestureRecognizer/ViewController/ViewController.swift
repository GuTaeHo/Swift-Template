//
//  ViewController.swift
//  MyGesture
//
//  Created by 구태호 on 2023/03/03.
//

import UIKit

class ViewController: UIViewController {
    /* 뷰 계층에 따른 이벤트 수신 여부 테스트 */
    @IBOutlet var correctParentView: UIView!
    @IBOutlet var correctChildView: UIView!
    @IBOutlet var wrongParentView: UIView!
    @IBOutlet var wrongChildView: UIView!
    
    /* 제스쳐 테스트 */
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentTextView: UITextView!
    
    var titleCount: Int = 0
    var contentCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correctChildView.addAction {
            self.showToast(message: "자식 뷰 클릭됨")
        }
        
        wrongChildView.addAction {
            self.showToast(message: "자식 뷰 클릭됨")
        }
        
        let titleClickGesture = UITapGestureRecognizer(target: self, action: #selector(titleCilcked))
        titleLabel.addGestureRecognizer(titleClickGesture)
        
        let contentClickGesture = UITapGestureRecognizer(target: self, action: #selector(contentClicked))
        contentTextView.addGestureRecognizer(contentClickGesture)
    }
    
    
    @objc func titleCilcked() {
        titleCount += 1
        print("titleCount = \(titleCount), contentCount = \(contentCount)")
        if titleCount > 2 && contentCount > 6 {
            showToast(message: "조건 만족됨")
        }
    }
    
    
    @objc func contentClicked() {
        contentCount += 1
            print("titleCount = \(titleCount), contentCount = \(contentCount)")
        if titleCount > 2 && contentCount > 6 {
            showToast(message: "조건 만족됨")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        contentTextView.resignFirstResponder()
    }
}

