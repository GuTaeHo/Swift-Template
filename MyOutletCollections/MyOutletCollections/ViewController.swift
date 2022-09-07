//
//  ViewController.swift
//  MyOutletCollections
//
//  Created by 구태호 on 2022/06/17.
//

import UIKit

class ViewController: UIViewController {
    
    // 화면에 표시된 UI의 개수가 많아질수록 outlet 또한 많아져 코드의 가독성을 해칠 수 있기때문에,
    // xcode는 Outlet Collection을 통해 Outlet을 하나로 묶어 제어할 수 있도록 제공하고있음
    @IBOutlet var lbText: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Outlet 콜렉션을 참조해 설정하기
        for i in 0..<lbText.count {
            let labelNumber = i + 1
            lbText[i].text = "\(labelNumber)번째 라벨 입니다"
        }
    }
}

