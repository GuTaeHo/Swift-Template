//
//  LastestViewController.swift
//  MyViewControllerProtocol
//
//  Created by 구태호 on 2023/07/23.
//

import UIKit

protocol SendDataFromLastestViewController {
    func received(data: String)
}

class LastestViewController: UIViewController {
    @IBOutlet var tfUserInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickButton(_ sender: UIButton) {
        if let text = tfUserInput.text {
            // 1. 이전 뷰 컨트롤러에 데이터를 주고 dismiss (사라지기 전 업데이트됨)
            // self.childIsGoneDelegate?.onData(sender: text)
            // dismiss(animated: true)
            
            dismiss(animated: true) {
                // 2. 현재 뷰 컨트롤러 dismiss, 이전 뷰 컨트롤러 데이터 줌 (사라진 후 업데이트 됨)
                if let parent = self.parent(type: ViewController.self) as? SendDataFromLastestViewController {
                    parent.received(data: text)
                }
            }
        }
    }
    
    deinit {
        print("LastestViewController DEINIT")
    }
}
