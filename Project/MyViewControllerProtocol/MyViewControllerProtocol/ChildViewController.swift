//
//  ChildViewController.swift
//  MyViewControllerProtocol
//
//  Created by 구태호 on 2022/11/05.
//

import UIKit

protocol ChildIsGoneDelegate {
    func onData(sender: String)
}

class ChildViewController: UIViewController {
    @IBOutlet var tfUserInput: UITextField!
    public var childIsGoneDelegate: ChildIsGoneDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onClickButton(_ sender: UIButton) {
        if let text = tfUserInput.text {
            // 1. 이전 뷰 컨트롤러에 데이터를 주고 dismiss (사라지기 전 업데이트됨)
            // self.childIsGoneDelegate?.onData(sender: text)
            // dismiss(animated: true)
            // 2. 현재 뷰 컨트롤러 dismiss, 이전 뷰 컨트롤러 데이터 줌 (사라진 후 업데이트 됨)
            dismiss(animated: true) {
                self.childIsGoneDelegate?.onData(sender: text)
            }
        }
    }
    
    @IBAction func onClickNextButton(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "LastestViewController") as? LastestViewController {
            
            self.present(viewController, animated: true)
        }
    }
    
    deinit {
        print("ChildViewController DEINIT")
    }
}
