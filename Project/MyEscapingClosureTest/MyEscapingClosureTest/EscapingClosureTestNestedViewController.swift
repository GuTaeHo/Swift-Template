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
        
        // MARK: 중첩된 클로저 내부에서 강한참조 시 순환참조가 발생한다.
        // MARK: 해결방법은 강한참조를 제거 또는 중첩된 클로저에도 weak self 를 통해 약하게 참조.
//        optionalClosure = { [weak self] in
//            guard let self else { return }
//            self.nestedOptionalClosure = {
//                print(self.globalVariable ?? "")
//            }
//        }
        
        // 중첩된 클로저 해결
        // 1. 약한 참조만 사용
        optionalClosure = { [weak self] in
            self?.nestedOptionalClosure = {
                print(self?.globalVariable ?? "")
            }
        }
        
        // 2. 중첩된 클로저에서 약한 참조 추가
//        optionalClosure = { [weak self] in
//            guard let self else { return }
//            self.nestedOptionalClosure = { [weak self] in
//                guard let self else { return }
//                print(self.globalVariable ?? "")
//            }
//        }
        
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

