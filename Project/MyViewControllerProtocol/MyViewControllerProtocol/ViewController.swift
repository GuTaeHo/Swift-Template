//
//  ViewController.swift
//  MyViewControllerProtocol
//
//  Created by 구태호 on 2022/11/05.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lbResponse: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func clickButton(_ sender: UIButton) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "ChildViewController") as? ChildViewController {
            
            viewController.childIsGoneDelegate = self
            self.present(viewController, animated: true)
        }
    }
}

extension ViewController: ChildIsGoneDelegate {
    func onData(sender: String) {
        lbResponse.text = sender
    }
}

extension ViewController: SendDataFromLastestViewController {
    func received(data: String) {
        lbResponse.text = data
    }
}

