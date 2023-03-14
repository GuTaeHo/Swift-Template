//
//  LogUtil.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/12.
//

import Foundation

class LogUtil {
    /// 콘솔 로그 출력
    /// - Parameters:
    /// - message: 출력 할 내용
    /// - context: 현재 클래스
    /// - methodName: 현재 메소드 명
    public static func print<T>(message: String, context: T, methodName: String = "???") {
        #if DEBUG
        let instanceName = String(describing: type(of: context))
        
        Swift.print("-------------------------------------------------- DEBUG[\(instanceName):\(methodName)()] --------------------------------------------------")
        Swift.print("\(message)")
        #endif
    }
}
