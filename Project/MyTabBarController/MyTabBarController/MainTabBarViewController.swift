//
//  MainTabBarViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/11/14.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    @IBOutlet var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 해당 뷰 컨트롤러에 배지 부착
        tabbar.addBadge(position: 0)
        tabbar.addBadge(position: 1)
        tabbar.addBadge(position: 2)
    }
}
