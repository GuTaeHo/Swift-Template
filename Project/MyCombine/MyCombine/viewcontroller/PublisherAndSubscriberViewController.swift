//
//  PublisherAndSubscriberViewController.swift
//  MyCombine
//
//  Created by 구태호 on 2023/07/01.
//

import UIKit
import Combine

/**
 콤바인의 publisher를 구독(subscriber)하는 3가지 방법
 1. subscribe() 메소드 사용
 2. sink() 메소드 사용 <-권장
 3. assign(to:on:) 메소드 사용
 */
class PublisherAndSubscriberViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: 1. subscribe() 메소드 사용
//        howToUseSubscribeMethod()
        
        // MARK: 2. sink() 메소드 사용
         howToUseSinkMethod()
        
        // MARK: 3. assign(to:on:) 메소드 사용
//         howToUseAssignMethod()
    }
    
    func howToUseSubscribeMethod() {
        let publisher = ["Cocobean", "RubyBean", "CacaoBean", "CoffeeBean", "JavaBean"].publisher
        publisher.subscribe(CocobeanSubscriber())
    }
    
    func howToUseSinkMethod() {
        /// - note: subscriber 에게 output을 "한번만" 출력한 다음 완료하는 publisher
        let publisher = Just("1. Cocobean")
        
        /// - note: sink = subscriber를 만들어 주는 메소드
        let subscriber = publisher.sink { value in
            print(value)
        }
        
        /// - note: receive 를 완료하고 난뒤 receiveCompletion 실행(성공적으로 받았다 이런의미인듯)
        let subscriberWithCompletion = publisher.sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print("2. finished")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, receiveValue: { value in
            print(value)
        })
    }
    
    func howToUseAssignMethod() {
        // 1. didSet을 통해 value 값이 바뀌면 새 값을 print
        class SomeObject {
            var value: String = "" {
                didSet {
                    print(value)
                }
            }
        }
        
        // 2. 위에서 만든 class의 instance를 선언
        let object = SomeObject()
        
        // 3. String 배열로 이뤄진 publisher를 생성
        let publisher = ["Hello", "world!"].publisher
        
        // 4. publisher를 구독하면서 새롭게 받은 값을 object의 value에 할당
        _ = publisher
            .assign(to: \.value, on: object)
        
        /// - note: sink() 가 완료와 값에 대한 이벤트를 처리할 수 있게 해준다면, assign(to:on:) 은 publiser 로 부터 받은 값을
        /// - note: 주어진 instance 의 property 에 할당할 수 있도록 해준다.
        /// - warning: 주어지는 값이 무조건 있어야하기 때문에 sink 와는 다르게 publisher 의 Failure 타입이 Never 일때만 사용가능
    }
}

/// 애플에서 권장하지 않는 방식 (별도로 선언하는 방식도 번거로움)
class CocobeanSubscriber: Subscriber {
    /// - note: subscriber 가 받을 값의 타입 지정
    typealias Input = String
    
    /// - note: subscriber 가 에러를 받을 수 없는 경우 Never 사용
    typealias Failure = Never
    
    /**
     subscriber 에게 publisher 를 성공적으로 구독했음을 알리고 item 을 요청(구독 시작)
     - parameter subscription: 이 subscription 을 사용해서 publisher 에게 item 을 요청해야함
     */
    func receive(subscription: Subscription) {
        print("구독 시작")
        /// publisher 에게 요청할 item 개수 지정
        /// - parameter unlimited: 무제한
        /// - parameter max: 최대 개수 제한
        /// - parameter none:no elements, max(0) 과 같음
        subscription.request(.max(2))
    }
    
    /**
     subscriber 에게 publisher 가 element 를 생성했음을 알림(이벤트 발생)
     */
    func receive(_ input: String) -> Subscribers.Demand {
        print(input)
        return .none
    }
    
    /**
     subscriber 에게 publisher 가 정상적으로 또는 오류로 publish 를 완료했음을 알림 (발행 성공)
     */
    func receive(completion: Subscribers.Completion<Never>) {
        print("완료")
    }
}

