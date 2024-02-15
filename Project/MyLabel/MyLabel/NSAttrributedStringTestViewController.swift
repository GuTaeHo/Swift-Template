//
//  NSAttrributedStringTestViewController.swift
//  MyLabel
//
//  Created by 구태호 on 2/6/24.
//

import UIKit

/**
 - 문제 -
 1. UILabel 의 text 및 attributedText 필드는 서로 독립적? 아니면 따로 움직일까?
 2. 좀 더 편리하게 attributedText 를 적용할 수 있는 방법이 없을까?
 3. 
 */
class NSAttrributedStringTestViewController: UIViewController {
    @IBOutlet var lbType1: UILabel!
    @IBOutlet var lbType2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testCase1()
        printAll()
    }
    
    func testCase1() {
        // `text` 와 `attributedText` 는 서로 동기화 된다.
        // `text` 와 `attributedText` 가장 마지막에 누가 저장되었는지에 따라 문자열을 출력한다
        // 이미 할당된 `attributedText` 가 있을경우 마지막에 할당된 `text` 는 문자열은 `text` 를 따라가되, 스타일은 그대로 적용된다.
        lbType1.text = "안녕 plain"   // "안녕 attributed"
        lbType1.attributedText = .init(string: "안녕 attributed")     // "안녕 attributed"
        lbType1.attributedText = .styledText("홀라 Styled Attributes", type: .pretendardBold, size: 20, color: .green)
        lbType1.attributedText = .styledText("Styled Attributes Styled Attributes Styled Attributes Styled Attributes Styled Attributes Styled Attributes", type: .pretendardRegular, size: 20, color: .green).toMutable.appendParagraphStyle(-5)
        lbType1.text = "zzzz"
    }
    
    func printAll() {
        print("lbType1.text = \(lbType1.text ?? "nil")")
        print("lbType1.attributedText.string = \(lbType1.attributedText?.string ?? "nil")")
    }
}
