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
        
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let navigationControllerCounts = navigationController?.viewControllers.count, navigationControllerCounts > 1 {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "OrangeViewController") as? OrangeViewController {
            viewController.dataClosure = { data in
                print("\(data)")
            }
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            print("뷰 컨트롤러 추가 오류...")
        }
    }
    
    @IBAction func currentViewController(_ sender: Any) {
        lbCurrentViewController.text = String(describing: type(of: self))
    }
    
    @IBAction func pushBySegue(_ sender: UIButton) {
        
    }
}

