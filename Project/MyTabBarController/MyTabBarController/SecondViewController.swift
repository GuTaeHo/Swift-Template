//
//  SecondViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/11/14.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet var ivBell: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.delegate = self
        ivBell.addGestureRecognizer(gestureRecognizer)
    }
}

extension SecondViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("bell clicked")
        
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "EmbededViewControllerForSecondViewController") {
            present(viewController, animated: true)
        }
        
        return true
    }
}
