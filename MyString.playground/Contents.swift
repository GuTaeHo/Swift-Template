import UIKit

let appleEmail = "d2fawfg4vs2@privaterelay.appleid.com"
let normalEmail = "cocobean3717@example.com"


appleEmail.contains("@privaterelay.appleid.com")


let characterSet = CharacterSet(charactersIn: "")
let spacingEmail = " coco bean 37  17 @test.com"

spacingEmail.components(separatedBy: characterSet).joined()
