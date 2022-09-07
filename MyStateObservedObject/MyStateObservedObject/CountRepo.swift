//
//  CountRepo.swift
//  MyStateObservedObject
//
//  Created by 구태호 on 2022/06/24.
//

import Foundation

class CountRepo: ObservableObject {
    // @Published > 값이 변동되면 View 에게 즉각적으로 알림
    // @Published var count: Int = 0
    
    var count: Int = 0 {
        willSet {
            print(newValue % 5)
            if newValue % 5 == 0 {
                objectWillChange.send()
            }
        }
    }
}
