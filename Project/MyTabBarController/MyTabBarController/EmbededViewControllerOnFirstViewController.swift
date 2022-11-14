//
//  EmbededViewControllerOnFirstViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/11/14.
//

import UIKit

class EmbededViewControllerOnFirstViewController: UIViewController {
    @IBOutlet var ivBack: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.delegate = self
        ivBack.addGestureRecognizer(gestureRecognizer)
    }
}

extension EmbededViewControllerOnFirstViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("ivBack clicked")
        
        navigationController?.popViewController(animated: true)
        
        return true
    }
}
