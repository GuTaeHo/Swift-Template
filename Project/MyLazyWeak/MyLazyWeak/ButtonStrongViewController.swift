//
//  ButtonStrongViewController.swift
//  MyLazyWeak
//
//  Created by 구태호 on 4/3/24.
//

import UIKit


class ButtonStrongViewController: UIViewController {
    @IBOutlet weak var testButton: UIButton!
    var testNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testButton.addAction { [weak self] in
            self?.testNumber += 1
            if self?.testNumber ?? 0 > 5 {
                self?.dismiss(animated: true)
            }
            print("\(self?.testNumber ?? 0)")
        }
    }
    
    deinit {
        print("ButtonStrongViewController deinit 됨")
    }
}
