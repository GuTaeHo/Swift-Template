//
//  GreenViewController.swift
//  MyTransitionsViewController
//
//  Created by 구태호 on 6/4/24.
//

import UIKit


class GreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(view.window?.rootViewController is ViewController)   // true
        print(view.window?.rootViewController is GreenViewController)   // false
    }
    
    @IBAction func dismissToRootVC(_ sender: UIButton) {
        guard let rootVC = getRootVC() else { return }
        rootVC.dismiss(animated: true)
    }
    
    func getRootVC() -> UIViewController? {
        var presentingVC = presentingViewController
        while true {
            if let presentVC =  presentingVC?.presentingViewController {
                presentingVC = presentVC
            } else {
                return presentingVC
            }
        }
    }
}
