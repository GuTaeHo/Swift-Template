//
//  EscapingClosureTestNestedViewController.swift
//  MyEscapingClosureTest
//
//  Created by 구태호 on 2023/05/25.
//

import UIKit

/**
 옵셔널로 선언된 클로저는 기본적으로 **escaping** 되며, escaping 클로저의 내부에서 강한참조 시, **순환참조가 발생**하여 메모리 누수가 일어난다.
 */
class EscapingClosureTestNestedViewController: UIViewController {
    // MARK: 옵셔널로 선언된 클로저는 escaping 된다.
    var optionalClosure: (() -> ())?
    var nestedOptionalClosure: (() -> ())?
    
    var globalVariable = "Hi, there"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 클로저가 중첩으로 선언되어있더라도, (외부 변수를) 약하게 참조 한다면 순환참조가 일어나지않음
        optionalClosure = { [weak self] in
            self?.nestedOptionalClosure = {
                print(self?.globalVariable ?? "")
            }
        }
        
        optionalClosure?()
        nestedOptionalClosure?()
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    deinit {
        print("EscapingClosureTestNestedViewController DEINIT")
    }
}

