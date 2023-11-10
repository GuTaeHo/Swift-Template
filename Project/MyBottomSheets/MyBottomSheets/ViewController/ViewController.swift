//
//  ViewController.swift
//  MyBottomSheets
//
//  Created by 구태호 on 11/10/23.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let bottomSheetView = CommonBottomSheetView(initialView: .full, viewTypes: [.full, .tip])
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSheetView)
        
        NSLayoutConstraint.activate([
            bottomSheetView.topAnchor.constraint(equalTo: view.topAnchor),
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

