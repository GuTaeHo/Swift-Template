//
//  ContentView.swift
//  MyFirstSwiftUI
//
//  Created by 구태호 on 2022/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("수평 스택").bold()
                Label("이미지 라벨", systemImage: "wifi.square")
            }
            
            VStack {
                Text("실시간 렌더링")
                    .padding(.all, 18.0)
                Label("이미지 라벨", systemImage: "fuelpump")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
