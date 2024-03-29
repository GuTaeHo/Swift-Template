//
//  DefaultFirstViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/12/02.
//

import UIKit

class DefaultFirstViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "DefaultSecondViewController") as? DefaultSecondViewController {
            // MARK: 뷰 컨트롤러가 push 될 때 하단 탭 바를 숨길건지 여부를 설정함
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
