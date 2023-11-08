//
//  ViewController.swift
//  MyUIResponder
//
//  Created by 구태호 on 2023/07/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var disabledButton: UIStackView!
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifying), name: .post, object: nil)
        
        print(disabledButton.next)
    }

    @objc func notifying() {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            textView.text = delegate.sharedText
        }
    }

    @IBAction func disableButton(_ sender: UIButton) {
        textView.text = "클릭됨"
    }
    
    @IBAction func printViewControllerOfButton(_ sender: UIButton) {
        textView.text = ""
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.sharedText = ""
        }
        _ = sender.viewController
    }
}

