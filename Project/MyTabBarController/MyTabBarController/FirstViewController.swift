//
//  ViewController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/11/14.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet var ivBell: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.delegate = self
        ivBell.addGestureRecognizer(gestureRecognizer)
    }
}

extension FirstViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("bell clicked")
        
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "EmbededViewControllerOnFirstViewController") {
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        return true
    }
}

