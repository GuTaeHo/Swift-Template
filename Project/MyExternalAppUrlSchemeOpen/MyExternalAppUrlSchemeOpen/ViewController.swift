//
//  ViewController.swift
//  MyExternalAppUrlSchemeOpen
//
//  Created by 구태호 on 2022/10/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func openAppleMap(_ sender: Any) {
        let urlScheme = "blossom://"

        if let url = URL(string: urlScheme), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("열지 못함")
        }
    }
}

