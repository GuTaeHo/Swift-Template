//
//  ThirdViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/11/21.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet var ivBell: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰 컨트롤러 호출 시 배지 제거
        self.tabBarController?.tabBar.removeBadge(position: 2)
    }
}
