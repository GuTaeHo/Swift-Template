//
//  ContentView.swift
//  MyFirstWatchOS Watch App
//
//  Created by 구태호 on 2023/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("강제 데이터 동기화")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
