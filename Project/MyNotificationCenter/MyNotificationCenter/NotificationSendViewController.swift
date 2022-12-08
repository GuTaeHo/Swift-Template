//
//  NotificationSendViewController.swift
//  MyNotificationCenter
//
//  Created by 구태호 on 2022/09/29.
//

import UIKit

// 필수적으로 숙지해야할 내용
// MARK: 1. Notification 은 등록된 만큼 해당 메소드를 호출시킴, 따라서 등록 후, 해제작업이 필수적임(단, deinit 이 호출되어 완전히 뷰 컨트롤러가 삭제되었다면 해제작업 필요 X)
// MARK: 2. removeObserver() 는 한번만 호출해도 (해당되는) 옵저버가 모두 삭제됨
// MARK: 3.  뷰 컨트롤러에 Notification 이 등록되었고, 해제하지 않았더라도, deinit() 이 호출된 뷰 컨트롤러라면 해당 post() 를 해도 해당 뷰 컨트롤러가 호출되지않음.
class NotificationSendViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickSendButton(_ sender: UIButton) {
        let text = textField.text ?? "입력된 값 없음"
        
        /// 5초 후 동작
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            let userInfo: [AnyHashable:Any] = ["text": text]
            
            // 해당 이름에 text를 실어서 방송
            NotificationCenter.default.post(name: .sendTextData, object: nil, userInfo: userInfo)
        }
    }
}

