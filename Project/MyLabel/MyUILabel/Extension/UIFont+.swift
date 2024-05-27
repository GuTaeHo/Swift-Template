//
//  UIFont+.swift
//  MyUILabel
//
//  Created by 구태호 on 1/31/24.
//

import UIKit


extension UIFont {
    enum FontType: String {
        case pretendardRegular = "Pretendard-Regular"
        case pretendardMedium = "Pretendard-Medium"
        case pretendardSemiBold = "Pretendard-SemiBold"
        case pretendardBold = "Pretendard-Bold"
    }
    
    /// 타입에 맞는 폰트를 반환합니다.
    /// - Warning: 폰트를 찾을 수 없을 때 시스템 폰트 반환
    static func font(_ type: UIFont.FontType, ofSize: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: ofSize) ?? .systemFont(ofSize: ofSize)
    }
    
    /// 타입에 맞는 폰트를 반환합니다.
    /// - Warning: 폰트를 찾을 수 없을 때 시스템 폰트 반환
    func font(_ type: UIFont.FontType, ofSize: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: ofSize) ?? .systemFont(ofSize: ofSize)
    }
    
    public static func checkFontList() {
        // 폰트 체크
        UIFont.familyNames.sorted().forEach{ familyName in
            print("@@@ 폰트 패밀리 - \(familyName)")
            UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
                print("@@@ 폰트 네임 - \(fontName)")
            }
            print("---------------------")
        }
    }
}
