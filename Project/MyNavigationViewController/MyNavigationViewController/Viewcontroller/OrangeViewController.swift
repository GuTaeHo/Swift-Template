//
//  OrangeViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class OrangeViewController: UIViewController {
    @IBOutlet var lbCurrentViewController: UILabel!
    
    public var dataClosure: ((Any) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sendDataPreviousViewController(_ sender: UIButton) {
        dataClosure?("안녕!")
    }
    
    @IBAction func previousViewController(_ sender: Any) {
        if let viewController = self.navigationController?.previousViewController(context: RedViewController.self) {
            lbCurrentViewController.text = String(describing: type(of: viewController))
        }
    }
}
