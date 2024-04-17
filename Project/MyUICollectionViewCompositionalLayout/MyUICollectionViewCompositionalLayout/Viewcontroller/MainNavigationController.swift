//
//  MainNavigationController.swift
//  MyUICollectionViewCompositionalLayout
//
//  Created by 구태호 on 4/17/24.
//

import UIKit


class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController()
        pushViewController(vc!, animated: true)
    }
}
