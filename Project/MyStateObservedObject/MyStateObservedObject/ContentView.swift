//
//  ContentView.swift
//  MyStateObservedObject
//
//  Created by 구태호 on 2022/06/24.
//

import SwiftUI

struct ContentView: View {
    // @State 변수에 "$"를 붙이면 Binding 형태로 반환함
    @State var isToggleOn: Bool = true
    @ObservedObject var countRepo = CountRepo()
    
    var body: some View {
        VStack {
            // 자식 뷰에게 isToggleOn 변수 전달
            ChildView(isToggleOn: $isToggleOn)
            if isToggleOn {
                Text("Toggle ON!")
            }
        }
        
        VStack {
            // 2. 즉각적으로 View에 반환되어 텍스트가 변경됨
            Text("\(self.countRepo.count)").font(.largeTitle)
            
            Button("숫자 증가") {
                // 1. @Published 로 선언된 count 변수가 증가되면
                self.countRepo.count += 1
            }
        }
    }
}

struct ChildView: View {
    // @Binding 어노테이션은 Binding<T>를 인자로 받아 초기화 시킴
    @Binding var isToggleOn: Bool
    
    var body: some View {
        Toggle(isOn: $isToggleOn) {
            Text("Text Hide")
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
