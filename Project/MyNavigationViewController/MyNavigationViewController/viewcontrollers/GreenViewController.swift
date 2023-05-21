//
//  GreenViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class GreenViewController: UIViewController {
    var bar: String?
    
    var escapingClosure: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 강한참조
        /*
        escapingClosure = { [weak self] in
            // bar 강한참조 발생!
            self?.bar = "FooBar"
        }
         */
        
        // 약한참조
        escapingClosure = { [weak self] in
            // bar 강한참조 발생!
            self?.bar = "FooBar"
        }
    }
    
    @IBAction func next(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func popAndPush(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "BlueViewController") as? BlueViewController {
            self.navigationController?.popToRootAndPushViewController(moveTo: viewController)
        }
    }
    
    deinit {
        // 호출 X
        print("GreenViewController deinit")
    }
}
