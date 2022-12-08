//
//  BaseViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/12/07.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    final override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        onViewWillAppear()
    }
    
    func onViewWillAppear() {}
}
