//
//  ViewController.swift
//  MyCarthage
//
//  Created by 구태호 on 3/31/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var label: UILabel {
        let label = UILabel()
        label.text = "Hello, World!"
        return label
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(20)
        }
    }


}

