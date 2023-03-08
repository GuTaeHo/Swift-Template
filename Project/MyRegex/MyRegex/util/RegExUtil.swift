//
//  RegExUitl.swift
//  MyRegex
//
//  Created by 구태호 on 2023/03/09.
//

import Foundation

class RegExUtil {
    /// 이메일
    private static let emailEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    /// 01로 시작 다음 0,1,7 가능 + (7~8 자리) 0 ~ 9 숫자
    private static let phoneEx = "^01[0-1, 7][0-9]{7,8}$"
    /// (8~30자리) 영문 + 숫자 + 특수 문자
    private static let passwordEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,30}"
    
    /// 이메일 체크
    static func isEmail(email: String?) -> Bool {
        guard let email = email, email != "" else { return false }
        if email.range(of: emailEx, options: .regularExpression) != nil {
            return true
        }
        return false
    }
    
    /// 휴대전화 정규식 체크
    /// - note: 하이픈이 포함된 문자일 경우 제거한 뒤 비교
    static func isPhoneNumber(phoneNumber: String?) -> Bool {
        guard let phoneNumber = phoneNumber, phoneNumber != "" else { return false }
        // 하이픈 제거
        let phoneNumberRemovedHyphen = phoneNumber.components(separatedBy: ["-"]).joined()
        
        if phoneNumberRemovedHyphen.range(of: phoneEx, options: .regularExpression) != nil {
            return true
        }
        return false
    }
    
    /// 패스워드 체크
    static func isPassword(password: String?) -> Bool {
        guard let password = password, password != "" else { return false }
        if password.range(of: passwordEx, options: .regularExpression) != nil {
            return true
        }
        return false
    }
}
