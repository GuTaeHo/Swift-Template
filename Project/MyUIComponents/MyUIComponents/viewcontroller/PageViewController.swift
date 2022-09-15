//
//  PageViewController.swift
//  MyUIComponents
//
//  Created by 구태호 on 2022/09/05.
//

import UIKit

// MARK: 하위에 UIViewController 들을 관리, 표시 하는 뷰 컨트롤러
class PageViewController: UIPageViewController {
    private var subViewControllers = [UIViewController]()
    
    private let viewControllerNames = ["FirstViewController", "SecondViewController", "ThirdViewController", "FourthViewController"]
    
    private var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. 뷰 컨트롤러 생성
        initViewControllers()
        
        // 2. 뷰 컨트롤러 저장
        // 3. 초기 뷰컨트롤러 지정
    }
    
    private func initViewControllers() {
        for viewControllerName in viewControllerNames {
            let storyboard = UIStoryboard(name: "PageControl", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "\(viewControllerName)")
            
            subViewControllers.append(viewController)
        }
        
        if let firstViewController = subViewControllers.first as? FirstViewController {
            self.setViewControllers([firstViewController], direction: .forward, animated: true)
        }
    }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let _ = viewController as? 
        
        if currentPage < pageViewController.viewControllers?.count {
            
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
}
