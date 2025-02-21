//
//  NumberAnimationTextView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 2/21/25.
//

import SwiftUI
import SoyBeanUI


/// - Note: iOS 16 이상 애니메이션 적용
struct NumberAnimationTextView: View {
    @Binding var number: Int
    
    var body: some View {
        if #available(iOS 16, *) {
            numberText
                .contentTransition(.numericText())
        } else {
            numberText
        }
    }
    
    @ViewBuilder
    var numberText: some View {
        Text("\(number)")
            .font(.custom(.bold700, size: 30))
    }
}
