//
//  Then+.swift
//  QRCodeReader
//
//  Created by 구태호 on 2023/09/09.
//

import UIKit

/**
 Xcode 14 부터 프로퍼티에서 아래 첫번째 코드처럼 사용할 시 타입을 추론할 수 없는 문제가 있습니다.
 
 기존 방식
 ```
 let label = UILabel().then {
    $0.text = "인성데이타"
    $0.textColor = .black
    $0.textAlignment = .center
 }
 ```
 
 다음과 같이 사용해야 제대로 타입을 추론할 수 있습니다.
 ```
 let label: UILabel = .init().then {
    $0.text = "라벨"
    $0.textColor = .black
    $0.textAlignment = .center
 }
 ```
 */

protocol Then {}


// MARK: - Extension

extension Then where Self: AnyObject {
    
    /// 초기화된 이후 클로저 구문을 통해 프로퍼티를 정의합니다
    ///
    ///     let label: UILabel = .init().then {
    ///         $0.text = "라벨"
    ///         $0.textColor = .black
    ///         $0.textAlignment = .center
    ///     }
    @inlinable
    func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}


extension Then where Self: Any {
    
    /// 클로저 구문을 통해 프로퍼티를 정의합니다
    ///
    ///     label.do {
    ///         $0.text = "라벨"
    ///         $0.textColor = .black
    ///         $0.textAlignment = .center
    ///     }
    @inlinable
    func `do`(_ block: (Self) throws -> Void) rethrows {
        try block(self)
    }
    
    /// 값을 copy한 후 클로저 구문을 통해 프로퍼티를 정의합니다
    ///
    ///     let size = CGSize().with {
    ///         $0.width = 100
    ///         $0.height = 100
    ///     }
    @inlinable
    func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}


extension NSObject: Then {}
extension Array: Then {}
extension Dictionary: Then {}
extension Set: Then {}
extension JSONDecoder: Then {}
extension JSONEncoder: Then {}

#if !os(Linux)
extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}
#endif

#if os(iOS)
extension UIEdgeInsets: Then {}
extension UIOffset: Then {}
extension UIRectEdge: Then {}
#endif
