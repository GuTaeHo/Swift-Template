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
    
    @IBAction func currentViewController(_ sender: Any) {
        lbCurrentViewController.text = String(describing: type(of: self))
    }
}

