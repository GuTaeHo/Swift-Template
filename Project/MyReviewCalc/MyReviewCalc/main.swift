//
//  main.swift
//  MyReviewCalc
//
//  Created by 구태호 on 2022/07/22.
//

import Foundation

while(true) {
    if let reviewCount = readLine() {
        print(reviewCalc(reviewCount: Int(reviewCount) ?? -1))
    }
}

func reviewCalc(reviewCount: Int) -> String {
    if reviewCount < 100 {
        return "\(reviewCount)"
    } else if reviewCount / 100 > 0, reviewCount / 100 < 10 {
        return "\((reviewCount / 100) * 100)+"
    } else if reviewCount / 1000 > 0, reviewCount / 1000 < 10{
        return "\((reviewCount / 1000) * 1000)+"
    } else {
        return "Review Count Error!"
    }
}
