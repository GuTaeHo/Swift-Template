import UIKit

class RegExpUtil {
    private static var REG_EMAIL = "[A-Z0-9a-z._%+-]+@[0-9a-zA-Z.-]+\\.[a-zA-Z]{2,3}"
    private static var REG_PASSWORD = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,15}"
    private static var REG_ID = "^[a-z]+[a-z0-9]{5,19}$"
    private static var REG_PHONE = "^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$"
    private static var REG_DEVICE_NICKNAME = "^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|]{2,10}"
    
    public static func isEmailCheck(email: String) -> Bool {
        let emailRegEx = REG_EMAIL
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if emailTest.evaluate(with: email) {
            return true
        } else {
            return false
        }
    }
    
    public static func isIdCheck(id: String) -> Bool {
        let idRegEx = REG_ID
        let idTest = NSPredicate(format: "SELF MATCHES %@", idRegEx)
        
        if idTest.evaluate(with: id) {
            return true
        } else {
            return false
        }
    }
    
    public static func isPasswordCheck(password: String) -> Bool {
        let passRegEx = REG_PASSWORD
        let passTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        
        if passTest.evaluate(with: password) {
            return true
        } else {
            return false
        }
    }
    
    // MARK: 패스워드 일치 여부 반환
    public static func isPasswordEqual(password: String, passwordCheck: String) -> Bool {
        if password == passwordCheck {
            return true
        } else {
            return false
        }
    }
    
    // MARK: 휴대전화번호 체크
    public static func isCellPhone(phoneNumber: String) -> Bool {
        let phoneRegEx = REG_PHONE
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        
        if phoneTest.evaluate(with: phoneNumber) {
            return true
        } else {
            return false
        }
    }
    
    public static func isNickname(nickname: String) -> Bool {
        return nickname.count >= 2 && nickname.count <= 10
    }
    
    public static func isDeviceName(deviceName: String) -> Bool {
        let deviceNameTest = NSPredicate(format: "SELF MATCHES %@", REG_DEVICE_NICKNAME)
        
        if deviceNameTest.evaluate(with: deviceName) {
            return true
        } else {
            return false
        }
    }
}

// let email = "dwfasd222@example.ac"
// RegExpUtil.isEmailCheck(email: email)

let id = "afwaff24242"
RegExpUtil.isIdCheck(id: id)

let deviceName = "우리친구할때프렌드가F"
RegExpUtil.isDeviceName(deviceName: deviceName)
