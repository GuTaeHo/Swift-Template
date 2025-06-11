//
//  LongPressView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 11/26/24.
//

import SwiftUI

struct LongPressView : View {
    @GestureState var isLongPressed = false

    var body: some View {
        let longPress = LongPressGesture()
            .updating($isLongPressed) { (value, state, transcation) in
                state = value
            }
        return Rectangle()
            .fill(isLongPressed ? Color.purple : Color.red)
            .frame(width: 300, height: 300)
            .cornerRadius(8)
            .shadow(radius: 8)
            .padding()
            .scaleEffect(isLongPressed ? 1.1 : 1)
            .gesture(longPress)
            .animation(.easeInOut, value: isLongPressed)
            .contentShape(Rectangle())
    }
}
