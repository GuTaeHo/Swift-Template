//
//  NotificationReceiveViewController.swift
//  MyNotificationCenter
//
//  Created by 구태호 on 2022/09/29.
//

import UIKit

class NotificationReceiveViewController: UIViewController {
    
    @IBOutlet var lbReceive: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 수신자 등록
        // MARK: Notification 은 등록된 만큼 해당 메소드를 호출시킴
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveText(_:)), name: .sendTextData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveText(_:)), name: .sendTextData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveText(_:)), name: .sendTextData, object: nil)
    }
    
    // 뷰 컨트롤러가 사라질 때 옵저버 제거
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // MARK: removeObserver() 의 인자에 name 이 없다면 -> 해당 뷰 컨트롤러의 모든 등록된 옵저버 제거
        // NotificationCenter.default.removeObserver(self)
        // MARK: removeObserver() 의 인자에 name 이 있다면 -> 해당 이름의 옵저버만 제거
        // MARK: removeObserver() 는 한번만 호출해도 (해당되는) 옵저버가 모두 삭제됨
        NotificationCenter.default.removeObserver(self, name: .sendTextData, object: nil)
    }
    
    @objc func didReceiveText(_ notification: Notification) {
        if let text = notification.userInfo?["text"] as? String {
            lbReceive.text = text
        }
    }
    
    @IBAction func nextController(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "NotificationReceiveSecondViewController" ) else {
            return
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func methodCallTestNextViewController(_ sender: Any) {
        NotificationCenter.default.post(name: .methodCallTest, object: nil)
    }
}
