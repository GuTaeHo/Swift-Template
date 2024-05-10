//
//  ViewController.swift
//  MyM13Checkbox
//
//  Created by 구태호 on 5/10/24.
//

import UIKit
import Then
import SnapKit
import M13Checkbox

class ViewController: UIViewController {
    lazy var m13CheckBox = M13Checkbox().then {
        $0.markType = .radio
        $0.boxType = .circle
        $0.boxLineWidth = 2
        $0.checkmarkLineWidth = 0
        $0.stateChangeAnimation = .expand(.fill)
        $0.tintColor = .blue
        /* 클릭 됐을 때 */
        $0.secondaryCheckmarkTintColor = .blue
        /* 클릭 안됐을 떄 */
        $0.secondaryTintColor = .systemGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(m13CheckBox)
        m13CheckBox.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(12)
        }
    }
}

