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
    
}

func foo<T>(metaType: T.Type) -> String {
    var string = String(describing: metaType)
    string += ", \(String(describing: T.self))"
    let account = Account()
    string += ", \(type(of: account))"
    string += ", \(type(of: Account.self))"
    
    return string
}

foo(metaType: Account.self)
