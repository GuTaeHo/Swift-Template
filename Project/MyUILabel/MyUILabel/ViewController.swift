//
//  ViewController.swift
//  MyUILabel
//
//  Created by 구태호 on 8/24/24.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    var marginedLabel = MarginedLabel().then {
        $0.text = "가나다라마바사"
        $0.textColor = .white
        $0.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(marginedLabel)
        marginedLabel.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(18)
        }
    }
}

