//
//  UITapGestureRecognizer+Combine.swift
//  MyUIScrollView
//
//  Created by 구태호 on 4/21/24.
//

import UIKit
import Combine


extension UITapGestureRecognizer {
    final class GestureSubscription<S: Subscriber, TapGestureRecognizer: UITapGestureRecognizer>: Subscription where S.Input == TapGestureRecognizer {
        private var subscriber: S?
        private let recognizer: TapGestureRecognizer
        
        init(subscriber: S, recognizer: TapGestureRecognizer, view: UIView) {
            self.subscriber = subscriber
            self.recognizer = recognizer
            recognizer.addTarget(self, action: #selector(tapEventHandler))
            view.addGestureRecognizer(recognizer)
        }
        
        func request(_ demand: Subscribers.Demand) { }
        
        func cancel() {
            subscriber = nil
        }
        
        @objc func tapEventHandler() {
            _ = subscriber?.receive(recognizer)
        }
    }
    
    struct GesturePublisher<TapGestureRecognizer: UITapGestureRecognizer>: Publisher {
        typealias Output = TapGestureRecognizer
        typealias Failure = Never
        
        private let recognizer: TapGestureRecognizer
        private let view: UIView
        
        init(recognizer: TapGestureRecognizer, view: UIView) {
            self.recognizer = recognizer
            self.view = view
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, TapGestureRecognizer == S.Input {
            let subscription = GestureSubscription(subscriber: subscriber,
                                                   recognizer: recognizer,
                                                   view: view)
            subscriber.receive(subscription: subscription)
        }
    }
}
