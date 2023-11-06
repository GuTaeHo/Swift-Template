//
//  UIView+.swift
//  MyCombineWithUIKitAndMVVM
//
//  Created by 구태호 on 11/6/23.
//

import UIKit
import Combine


extension UIView {
    func controlPublisher(for event: UIControl.Event) -> UIView.EventPublisher {
        return UIView.EventPublisher(view: self, event: event)
    }
    
    /// `Publisher`
    struct EventPublisher: Publisher {
        typealias Output = UIView
        typealias Failure = Never
        
        let view: UIView
        let event: UIControl.Event
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIView == S.Input {
            let subscription = EventSubscription(view: view, subscrier: subscriber, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
    
    /// `Subscription`
    fileprivate class EventSubscription<EventSubscriber: Subscriber>: Subscription where EventSubscriber.Input == UIView, EventSubscriber.Failure == Never {
        let view: UIView
        let event: UIControl.Event
        var subscriber: EventSubscriber?
        
        init(view: UIView, subscrier: EventSubscriber, event: UIControl.Event) {
            self.view = view
            self.subscriber = subscrier
            
            let gesture = UIGestureRecognizer(target: self, action: #selector(eventDidOccur))
            
            view.addGestureRecognizer(gesture)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
        }
        
        @objc func eventDidOccur() {
            _ = subscriber?.receive(view)
        }
    }
}
