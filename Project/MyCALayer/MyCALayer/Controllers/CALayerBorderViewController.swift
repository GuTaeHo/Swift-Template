//
//  CALayerBorderViewController.swift
//  MyCALayer
//
//  Created by 구태호 on 3/29/24.
//

import UIKit


class CALayerBorderViewController :UIViewController {
    @IBOutlet var borderView: UIView!
    @IBOutlet var lbBorder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        borderView.round(corners: [.topLeft, .topRight], cornerRadius: 10, borderColor: .orange, borderWidth: 3)
    }
}