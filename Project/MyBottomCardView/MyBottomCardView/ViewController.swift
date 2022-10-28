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
        let contentView = ContentView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 4))
        
        CardViewUtil.showCardViewController(context: self, contentView: contentView, isHandleVisible: true, cornerRadius: 24, isCancelButtonVisible: true, isSubmitButtonVisible: true)
    }
}

