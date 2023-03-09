//
//  FormatUtil.swift
//  MyRegex
//
//  Created by 구태호 on 2023/03/09.
//

import Foundation

class FormatUtil {
    /// 전화번호 하이픈 포함하여 반환
    /// - parameter number: 입력된 휴대전화 번호
    /// - note: XXX-XXX-XXXX 또는 XXX-XXXX-XXXX 포맷 지원
    static func phoneNumber(number: String) -> String {
        // 하이픈 제거
        var numberRemovedHyphen = number.components(separatedBy: ["-"]).joined()
        
        if numberRemovedHyphen.count == 11 {
            // 완성형 번호(XXX-XXXX-XXXX)
            numberRemovedHyphen.insert("-", at: numberRemovedHyphen.index(numberRemovedHyphen.startIndex, offsetBy: 3))
            numberRemovedHyphen.insert("-", at: numberRemovedHyphen.index(numberRemovedHyphen.startIndex, offsetBy: 8))
            return numberRemovedHyphen
        } else if numberRemovedHyphen.count > 7 {
            // XXX-XXX-XXXX
            numberRemovedHyphen.insert("-", at: numberRemovedHyphen.index(numberRemovedHyphen.startIndex, offsetBy: 3))
            numberRemovedHyphen.insert("-", at: numberRemovedHyphen.index(numberRemovedHyphen.startIndex, offsetBy: 7))
            return numberRemovedHyphen
        } else if numberRemovedHyphen.count > 3 {
            // XXX-X
            numberRemovedHyphen.insert("-", at: numberRemovedHyphen.index(numberRemovedHyphen.startIndex, offsetBy: 3))
            return numberRemovedHyphen
        } else {
            return number
        }
    }
}
