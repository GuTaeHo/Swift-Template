//
//  NumberAnimationView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 4/29/25.
//

import SwiftUI
import SoyBeanUI
import SoyBeanUtil

struct NumberAnimationView: View {
    let timer = Timer.publish(every: 1,
                              on: .main,
                              in: .common).autoconnect()
    @State private var numberCount: Int = 0
    
    var body: some View {
        NumberAnimationTextView(font: .custom(.IBMPlexBold,
                                              size: 30),
                                number: numberCount)
            .onReceive(timer) { _ in
                withAnimation {
                    numberCount += Int.random(in: 0..<10)
                }
            }
        Button(action: {
            AppUtil.exitApp()
        }) {
            Text("앱 종료")
        }
    }
}
