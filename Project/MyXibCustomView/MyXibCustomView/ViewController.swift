//
//  ViewController.swift
//  MyXibCustomView
//
//  Created by 구태호 on 2022/11/09.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customView: CocobeanView = UIView.loadFromNib() {
            view.addSubview(customView)
            customView.snp.remakeConstraints
            {
                $0.centerX.centerY.equalToSuperview()
                $0.width.equalToSuperview().inset(36)
            }
        }
    }
}

