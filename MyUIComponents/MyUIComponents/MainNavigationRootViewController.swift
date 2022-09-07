//
//  MainNavigationRootViewController.swift
//  MyUIComponents
//
//  Created by 구태호 on 2022/08/10.
//

import UIKit


// Interface Builder 대신 코드로 Navigation RootViewController 지정
class MainNavigationRootViewController: UIViewController {
    
    private let viewControllerNames = ["FirstViewController", "SecondViewController", "ThirdViewController", "FourthViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation View Controller 의 모든 View Controller 들을 관리하기 위한 ViewController
        let rootViewController = UINavigationController(rootViewController: self)
        
        for viewControllerName in viewControllerNames {
            let storyboard = UIStoryboard(name: "PageControl", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "\(viewControllerName)")
            
            rootViewController.pushViewController(viewController, animated: true)
        }
    }
}
