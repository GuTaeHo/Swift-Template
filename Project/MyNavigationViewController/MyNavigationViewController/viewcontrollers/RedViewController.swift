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
        
        // 네비게이션 바를 숨긴상태에서 밑의 코드는 동작하지 않음
        // self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // popGesture의 대리자를 초기화 시켜주면 동작하는 듯.
        // MARK: 대신 반드시 rootViewController 에 해당하는 UIViewController 에 아래코드를 지정해야 정상적으로 동작함
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let navigationControllerCounts = navigationController?.viewControllers.count, navigationControllerCounts > 1 {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "OrangeViewController") {
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            print("뷰 컨트롤러 추가 오류...")
        }
    }
    
    @IBAction func currentViewController(_ sender: Any) {
        lbCurrentViewController.text = String(describing: type(of: self))
    }
}

