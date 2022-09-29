//
//  StackTestViewController.swift
//  MySnapKit
//
//  Created by 구태호 on 2022/09/23.
//

import UIKit
import SnapKit

class StackTestViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var secondView: UIView!
    @IBOutlet var thirdView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondView.
        thirdView.snp.updateConstraints { make in
            make.height.equalTo(secondView)
        }
    }
}
