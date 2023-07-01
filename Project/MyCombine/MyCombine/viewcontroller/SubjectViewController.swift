//
//  SubjectViewController.swift
//  MyCombine
//
//  Created by 구태호 on 2023/07/01.
//

import UIKit
import Combine

/**
 subject 의 종류는 크게 2가지로 나뉜다
 - PassthroughSubject: subscriber 에게 element 를 broadcase 하는 subject
 - CurrentValueSubject: 초기값과 최근 발행된 element 에 대한 buffer 를 갖는 subject
 */
class SubjectViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        howToUsePassthroughSubject()
        howToUseCurrentValueSubject()
    }
    
    private func howToUsePassthroughSubject() {
        /**
         PassthroughSubject 는 send() 를 통해 stream 에 값을 주입할 수 있는 publisher 이다.
         */
        // 1. String과 Never 타입의 PassthroughSubject 객체를 생성
        let subject = PassthroughSubject<String, Never>()
        
        // 2.sink 를 이용하여 subscription1 을 생성
        let subscription1 = subject
            .sink(
                receiveCompletion: { completion in
                    print("subscription2 완료됨 - ", completion)
                },
                receiveValue: { value in
                    print("subscription1 값 받음 - ", value)
                }
            )
        // 3.sink 를 이용하여 subscription2 을 생성
        let subscription2 = subject
            .sink(
                receiveCompletion: { completion in
                    print("subscription2 완료됨 - ", completion)
                },
                receiveValue: { value in
                    print("subscription2 값 받음 - ", value)
                }
            )
        // 4. 값을 보냄
        /// - note: 해당 subject 를 구독중인 모든 subscriber 에게 값을 전달(BroadCast)
        subject.send("Hello")
        subject.send("World")
        
        // 5. subscription1 구독 취소
        subscription1.cancel()
        
        // 6. 재 전송
        /// - note: subscription1 이 구독을 취소했기 때문에 subscription2 만 메시지를 받게됨
        subject.send("메세지 재전송")
        
        // 7. 완료 이벤트 전달 (finished)
        subject.send(completion: .finished)
        
        // 8. 다시 재 전송
        /// - note: 완료 이벤트가 실행되었기때문에 아래 send() 를 통한 브로드캐스팅이 실행되지않음
        subject.send("마지막 메세지 전달")
    }
    
    private func howToUseCurrentValueSubject() {
        var subscriptions = Set<AnyCancellable>()
        // 1. Int와 Never 타입을 갖는 CurrentValueSubject를 생성
        // 1-1. CurrentValueSubject는 반드시 초기값이 지정되어야한다. 여기서는 0
        let subject = CurrentValueSubject<Int, Never>(0)
        
        // 2. sink를 통해 subject를 구독한다. (Failure Type이 Never일때 receiveCompletion은 생략가능)
        subject
            .sink(receiveValue: { print($0) })
            .store(in: &subscriptions) // 3. subcription을 subscriptions 묶음에 저장
        
        /**
         PassthroughSubject 에서는 직접 subscription.cancel() 을 통해 구독 상태를 취소했지만,
         CurrentValueSubject 에서는 위와같은 작업을 store(in:) 메소드를 통해 진행하며, 인자로 전달된 Set<AnyCancelable> 이 해제될 떄 자동으로 취소된다.
         
         - note: store(in:) 메소드의 파라미터는 in-out 으로 전달된다. 이는 **함수 내부**에서 파라미터의 값을 바꾸고 싶을 때, 해당 함수가 종료되어도 변경 사항을 유지하고 싶을 때 사용된다.
         */
        
        
        // 3. Passthrough 와 마찬가지로 send() 를 통해 새 값 전달(발행)
        subject.send(1)
        subject.send(2)
        
        // 4. subject.value 를 통해 설정된 현재 값 확인 가능
        print("현재 지정된 값: \(subject.value)")
        
        // 4-1. 아래와 같이 값을 밀어넣어 현재 값 변경이 가능하다.
        subject.value = 3
        print("현재 지정된 값: \(subject.value)")
        
        // 5. PassthroughSubject 처럼 완료이벤트를 발행하고 싶다면 .finished 전송
        subject.send(completion: .finished)
    }
}

