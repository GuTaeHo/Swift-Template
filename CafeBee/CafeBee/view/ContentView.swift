//
//  ContentView.swift
//  CafeBee
//
//  Created by 구태호 on 2022/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // 하위 뷰를 분리해서 구현
        LaunchScreenIconView()
        
        // 뷰가 화면에 보일 경우 호출
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    initApp()
                }
            }
        
        // 뷰가 화면에서 사라질경우 호출
            .onDisappear {
                print("ContentView 퇴장")
            }
    }
    
    private func initApp() {
        
    }
}

struct LaunchScreenIconView: View {
    // @State > 상태 프로퍼티, 현재 뷰의 상태(눌림, 체크됨, 텍스트가 작성된 경우)를 저장하는 멤버변수임
    
    var body: some View {
        let imageWidth = UIScreen.main.bounds.width / 2
        let imageHeight = imageWidth
        
        VStack(spacing: 20) {
            // Image view에 Button을 감싸 버튼 기능을 추가
            Button(action: clickedIcon) {
                Image("imgHoneycomb")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
            }
            Text("Cafe Bee")
                .font(.LAUNCH_SCREEN_TITLE_FONT)
                .foregroundColor(.LAUNCH_SCREEN_TITLE_NAME)
                
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.MAIN_BACKGROUND)
            .edgesIgnoringSafeArea(.all)
    }
    
    func clickedIcon() {
        NavigationLink(destination: MainView()) {}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.colorScheme, .light)
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}
