//
//  ViewController.swift
//  MyViewController
//
//  Created by 구태호 on 2023/01/11.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func showAlpha(_ sender: Any) {
        showAlphaViewController()
    }

    public func showAlphaViewController() {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "AlphaViewController") as? AlphaViewController else {
            return
        }
        
        present(viewController, animated: true)
    }
    
    public func showBravoViewController() {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "BravoViewController") as? BravoViewController else {
            return
        }
        
        present(viewController, animated: true)
    }
    
    public func showCharlieViewController() {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "CharlieViewController") as? CharlieViewController else {
            return
        }
        
        present(viewController, animated: true)
    }
}

