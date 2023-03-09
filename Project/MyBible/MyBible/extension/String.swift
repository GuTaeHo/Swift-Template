//
//  String.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import Foundation


extension String {
    /// 문자열에 포함된 특정 문자 삭제
    /// - parameter separater: 제거하고 싶은 문자
    /// - note: "-" "@" 등등
    func trim(separater: String) -> String {
        let separater = CharacterSet(charactersIn: separater)
        return self.components(separatedBy: separater).joined()
    }
    
    /**
     문자열 자르기
     - parameter from: 시작 인덱스 (원하는 문자 인덱스)
     - parameter to: 끝 인덱스 (원하는 문자 다음 인덱스)
     - note: ex) "CocoaPods" -> from: 0, to: 5 == "Cocoa"
     - note: ex) "CocoaPods" -> from: 5, to: 9 == "Pods"
     ```
     let cocobean = "Cocobean3717"
     
     let subStringedCocobean = cocobean.substring(from: 4, to: 10)
     print(subStringedCocobean) // bean37
     ```
     */
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to)
        
        return String(self[startIndex ..< endIndex])
    }
}
