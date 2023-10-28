//
//  ViewModeling.swift
//  MyCombineWithUIKitAndMVVM
//
//  Created by 구태호 on 10/27/23.
//

import Foundation

/// ViewModel 이 기본적으로 채택하는 Protocol.
protocol ViewModeling {
    /// (사용자 이벤트) 인풋 타입
    associatedtype Input
    /// (처리 결과) 출력 타입
    associatedtype Output
    
    /// 사용자 이벤트를 처리 결과로 변환합니다.
    func transform(input: Input) -> Output
}
