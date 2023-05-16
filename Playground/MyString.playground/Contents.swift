import UIKit


extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to)
        
        return String(self[startIndex ..< endIndex])
    }
}

let appleEmail = "d2fawfg4vs2@privaterelay.appleid.com"
let normalEmail = "cocobean3717@example.com"


appleEmail.contains("@privaterelay.appleid.com")


let characterSet = CharacterSet(charactersIn: "")
let spacingEmail = " coco bean 37  17 @test.com"

spacingEmail.components(separatedBy: characterSet).joined()

let beforeProcessingInsertBoardDate = "202209141122"
let currentDate = "20220914"


// 스트링 시작부터 지정된 자리까지 끊기
let insertBoardDate = beforeProcessingInsertBoardDate.substring(from: 0, to: 8)

if insertBoardDate == currentDate {
    print(true)
} else {
    print(false)
}


class Account {
    var name: String?
}

func foo<T>(metaType: T.Type) {
    let account = Account()
    account.name = "cocobean"
    
    // type(of: object) - 오브젝트의 타입 반환
    // 인스턴스 -> 클래스 반환
    // 클래스 -> 클래스 메타타입 반환
    
    print(type(of: account))                    // "Account"
    print(String(describing: T.self))           // "Account"
    print(String(describing: metaType))         // "Account"
    print(String(describing: account))         // "Account"
    print(type(of: Account.self))               // "Account.Type"
    print(type(of: T.self))                     // "Account.Type"
    print(type(of: metaType))                   // "Account.Type"
}

foo(metaType: Account.self)
