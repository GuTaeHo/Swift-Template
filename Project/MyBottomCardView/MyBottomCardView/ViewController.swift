//
//  ViewController.swift
//  MyBottomCardView
//
//  Created by 구태호 on 2022/10/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showCardViewController(_ sender: UIButton) {
        CardViewUtil.showCardViewController(context: self, isHandleVisible: false, cornerRadius: 24, isCancelButtonVisible: true, isSubmitButtonVisible: true)
    }
}

