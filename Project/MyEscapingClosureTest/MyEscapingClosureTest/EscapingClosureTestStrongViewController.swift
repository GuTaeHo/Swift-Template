//
//  EscapingClosureTestStrongViewController.swift
//  MyEscapingClosureTest
//
//  Created by 구태호 on 2023/05/24.
//

import UIKit

/**
 옵셔널로 선언된 클로저는 기본적으로 **escaping** 되며, 
 escaping 클로저의 내부에서 외부변수를 사용하거나, 클로저를 프로퍼티에 저장했을 때,
 강하게 참조하면 **순환참조가 발생**하여 메모리 누수가 일어난다.
 */
class EscapingClosureTestStrongViewController: UIViewController {
    // MARK: 옵셔널로 선언된 클로저는 escaping 된다.
    var optionalClosure: (() -> ())?
    
    var globalVariable = "Hi, there"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        optionalClosure = {
            // MARK: 클로저 내부에서 외부 뷰 컨트롤러를 강하게 참조하는 상태
            print(self.globalVariable)
        }
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    deinit {
        print("EscapingClosureTestStrongViewController DEINIT")
    }
}

