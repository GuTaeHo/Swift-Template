//
//  PresentTestViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 3/13/24.
//

import UIKit


class PresentTestViewController: UIViewController {
    @IBOutlet weak var lbParentName: UILabel!
    @IBOutlet weak var lbPresentingViewControllerName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let parent {
            lbParentName.text = "\(type(of: parent))"
        } else {
            lbParentName.text = "없음"
        }
        
        if let presentingViewController {
            lbPresentingViewControllerName.text = "\(type(of: presentingViewController))"
        } else {
            lbPresentingViewControllerName.text = "없음"
        }
    }
}
