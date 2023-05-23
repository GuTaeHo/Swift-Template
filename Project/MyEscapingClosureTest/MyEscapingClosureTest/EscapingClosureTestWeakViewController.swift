//
//  EscapingClosureTestWeakViewController.swift
//  MyEscapingClosureTest
//
//  Created by 구태호 on 2023/05/24.
//

import UIKit

/**
 옵셔널로 선언된 클로저는 기본적으로 **escaping** 되며, escaping 클로저의 내부에서 강한참조 시, **순환참조가 발생**하여 메모리 누수가 일어난다.
 */
class EscapingClosureTestWeakViewController: UIViewController {
    // MARK: 옵셔널로 선언된 클로저는 escaping 된다.
    var optionalClosure: (() -> ())?
    
    var globalVariable = "Hi, there"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        optionalClosure = { [weak self] in
            // MARK: 클로저 내부에서 외부 뷰 컨트롤러를 약하게 참조하는 상태
            print(self?.globalVariable)
        }
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    deinit {
        print("EscapingClosureTestWeakViewController DEINIT")
    }
}

