//
//  MainTabBarViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/11/14.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    @IBOutlet var tabbar: UITabBar!
    lazy var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 해당 뷰 컨트롤러에 배지 부착
        tabbar.addBadge(position: 0)
        tabbar.addBadge(position: 1)
        tabbar.addBadge(position: 2)
        
        containerView = UIView()
        containerView.backgroundColor = .red
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // anchor your view right above the tabBar
        containerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // anchor your view right above the tabBar
        containerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
    }
}
