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
    private static let phoneEx = "^01[0-1, 7][0-9]{3,4}[0-9]{4}$"
    /// 하이픈이 포함된 전화번호 일 경우
    private static let phoneExWithHyphen = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
    /// (8~30자리) 영문 + 숫자 + 특수 문자
    private static let passwordEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,30}"
    
    /// 사업자 번호 여부 ex. 0112233333
    private static let businessNumberEx = "^([0-9]{10})$"
    /// 하이픈이 포함된 사업자 번호 여부 ex. 011-22-33333
    private static let businessNumberExWithHyphen = "^([0-9]{3})-?([0-9]{2})-?([0-9]{5})$"
    
    /// 한글 & 영문 & 숫자 & 공백 허용
    private static let onlyTextEx = "[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9\\s]$"
    
    /// 이메일 체크
    static func isEmail(email: String?) -> Bool {
        guard let email = email, email != "" else { return false }
        if email.range(of: emailEx, options: .regularExpression) != nil {
            return true
        }
        return false
    }
    
    /// 휴대전화 정규식 체크
    /// - note: 하이픈이 포함된 문자일 경우 포함
    static func isPhoneNumber(phoneNumber: String?) -> Bool {
        guard let phoneNumber = phoneNumber, phoneNumber != "" else { return false }
        
        if phoneNumber.contains("-") {
            if phoneNumber.range(of: phoneExWithHyphen, options: .regularExpression) != nil {
                return true
            }
        } else {
            if phoneNumber.range(of: phoneEx, options: .regularExpression) != nil {
                return true
            }
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
    
    // 사업자 번호 여부 반환
    /// - note: 하이픈이 포함된 문자일 경우 하이픈 제거하여 정규식 체크
    static func isBusinessNumber(number: String?) -> Bool {
        guard let number = number, number != "" else { return false }
        
        if number.contains("-") {
            if number.range(of: businessNumberExWithHyphen, options: .regularExpression) != nil {
                return true
            }
        } else {
            if number.range(of: businessNumberEx, options: .regularExpression) != nil {
                return true
            }
        }
        return false
    }
    
    // 한글 & 영문 & 숫자 & 공백 포함된 경우
    static func isOnlyText(text: String?) -> Bool {
        guard let text = text, text != "" else { return false }
        if text.range(of: onlyTextEx, options: .regularExpression) != nil {
            return true
        }
        return false
    }
}
