//
//  FirstView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 2/21/25.
//

import SwiftUI
import SoyBeanUI


struct FirstView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var numberCount: Int = 0
    
    var body: some View {
        NumberAnimationTextView(number: numberCount)
            .onReceive(timer) { _ in
                withAnimation {
                    numberCount += Int.random(in: 0..<10)
                }
            }
    }
}
