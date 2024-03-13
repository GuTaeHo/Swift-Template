//
//  RedViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class RedViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet var lbCurrentViewController: UILabel!
    
    public var dummyDataNextViewController = "아아 한잔 주세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("RedViewController 의 부모 뷰 컨트롤러 : \(parent)")
        print("RedViewController 를 표시한 뷰 컨트롤러: \(presentingViewController)")
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let navigationControllerCounts = navigationController?.viewControllers.count, navigationControllerCounts > 1 {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func currentViewController(_ sender: Any) {
        lbCurrentViewController.text = String(describing: type(of: self))
    }
}

