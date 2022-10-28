//
//  ViewController.swift
//  MyBottomCardView
//
//  Created by 구태호 on 2022/10/26.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showCardViewController(_ sender: UIButton) {
        // 커스텀 뷰 생성
        let contentView = ContentView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 3))
        
        let cancelClosure = {
            print("취소 됨...")
        }
        
        let submitClosure = {
            print("kePler")
        }
        
        CardViewUtil.showCardViewController(context: self, contentView: contentView, isHandleVisible: true, isCancelButtonVisible: true, cancelText: "Nxde", cancelClosure: cancelClosure, isSubmitButtonVisible: true, submitText: "WeFresh", submitClosure: submitClosure)
    }
}

