//
//  YellowViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class YellowViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 현재 최 상단 뷰 컨트롤러 (YellowViewController 자기 자신) 프린트
        if let viewController = self.navigationController?.topViewController as? YellowViewController {
            print("\(String(describing: type(of: viewController)))")
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "GreenViewController") {
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            print("뷰 컨트롤러 추가 오류...")
        }
    }
}
