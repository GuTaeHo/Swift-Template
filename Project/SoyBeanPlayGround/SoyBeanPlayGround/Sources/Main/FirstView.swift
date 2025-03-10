//
//  FirstView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 2/21/25.
//

import SwiftUI
import SoyBeanUI
import SoyBeanUtil


struct FirstView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var numberCount: Int = 0
    
    var body: some View {
        VStack {
            NumberAnimationTextView(font: .custom(.IBMPlexBold,
                                                  size: 30),
                                    number: numberCount)
                .onReceive(timer) { _ in
                    withAnimation {
                        numberCount += Int.random(in: 0..<10)
                    }
                }
            Button(action: {
                Util.exitApp()
            }) {
                Text("앱 종료")
            }
        }
    }
}
