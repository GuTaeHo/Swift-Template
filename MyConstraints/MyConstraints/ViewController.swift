//
//  ViewController.swift
//  MyConstraints
//
//  Created by 구태호 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var lbCart: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let panelHeight = view.frame.height
        let bottomSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        
        NSLayoutConstraint.deactivate(buttonView.constraints)
    
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        // buttonView.addConstraint(NSLayoutConstraint(item: buttonView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        buttonView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomSafeArea).isActive = true
    }
}

