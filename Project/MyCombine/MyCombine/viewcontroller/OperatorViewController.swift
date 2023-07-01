//
//  OperatorViewController.swift
//  MyCombine
//
//  Created by 구태호 on 2023/07/01.
//

import UIKit
import Combine

/**
 prepend() 메소드를 사용하여 publisher 가 방출하는 element 의 **앞에 값을 추가**할 수 있다.
 append() 메소드를 사용하여 publisher 가 방출하는 element 의 **뒤에 값을 추가**할 수 있다.
 */

class OperatorViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        howToUsePrepend()
        //        howToUsePrependSequence()
        //        howToUsePrependPublisher()
        howToUseAppend()
    }
    
    private func howToUsePrepend() {
        // 1. 3과 4를 방출하는 publisher 생성
        let publisher = [3, 4].publisher
        
        // 2. prepend 함수를 통해 publisher의 고유 값 앞에 1과 2를 덧붙인다.
        _ = publisher
            .prepend(1, 2)
        // 3. 한번 더 prepend 함수를 붙여준다.
            .prepend(-1, 0)
            .sink(receiveValue: { print($0) })
        
        // MARK: prepend() 는 가장 마지막에 호출된 함수[-1,0]가 upstream 에 먼저 작용해서 발행된다.
    }
    
    private func howToUsePrependSequence() {
        // 1. 5,6,7 을 방출하는 publisher
        let publisher = [5, 6, 7].publisher
        
        // 2. 기존 publisher에 prepend(Sequence)를 세번 체이닝
        publisher
            .prepend(3, 4)
            .prepend(Set(1...2))
            .prepend(stride(from: 6, through: 10, by: 2))
            .sink(receiveValue: { print($0) })
        
        
        // MARK: Set 콜렉션은 순서를 보장하지 않기 때문에 순서가 매번 다르게 나올 수 있다.
    }
    
    /// publisher 들에서 발행되는 값을 결합 시키고 싶은 경우
    private func howToUsePrependPublisher() {
        // 1. 2개의 publisher 생성
        let publisher1 = [3, 4].publisher
        let publisher2 = [1, 2].publisher
        
        // 2. publisher2를 publisher1에 결합
        publisher1
            .prepend(publisher2)
            .sink(receiveValue: { print($0) })
    }
    
    private func howToUseAppend() {
        // 1. 1을 방출하는 publisher
        let publisher = [1].publisher
        // 2. append를 두번 사용해서 2와 3, 그리고 4를 뒤쪽에 붙여줌
        publisher
            .append(2, 3)
            .append(4)
            .sink(receiveValue: { print($0) })
    }
    
    // MARK: 나머지 append(sequence), append(publisher) 도 동일
}
