//
//  AccountViewModel.swift
//  MyBible
//
//  Created by 구태호 on 2023/05/01.
//

import Foundation
import RxCocoa
import RxSwift

class AccountViewModel {
    /* 값이 아니기 때문에 let 으로 선언 */
    let name: BehaviorRelay<String> = .init(value: "이름")
    let age: BehaviorRelay<String> = .init(value: "나이")
    
    let combinedAccount: Driver<String>
    
    init() {
        combinedAccount = Driver.combineLatest(
            name.asDriver(),
            age.asDriver()
        ).map({ name, age in
            return "\(name) : \(age)"
        }).asDriver()
    }
}
