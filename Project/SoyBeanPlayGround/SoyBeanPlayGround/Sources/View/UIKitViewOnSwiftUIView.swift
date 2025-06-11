//
//  UIKitViewOnSwiftUIView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 6/11/25.
//

import SwiftUI
import SoyBeanUI

struct UIKitViewOnSwiftUIView: View {
    @State var text = ""
    
    var body: some View {
        UIKitView(text: $text)
            .frame(height: 50)
        Spacer()
    }
}

#Preview {
    UIKitViewOnSwiftUIView(text: "")
}
