//
//  ViewController.swift
//  MyGesture
//
//  Created by 구태호 on 2023/03/03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var correctParentView: UIView!
    @IBOutlet var correctChildView: UIView!
    @IBOutlet var wrongParentView: UIView!
    @IBOutlet var wrongChildView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correctChildView.addAction {
            self.showToast(message: "자식 뷰 클릭됨")
        }
        
        wrongChildView.addAction {
            self.showToast(message: "자식 뷰 클릭됨")
        }
    }
}

