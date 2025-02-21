import SwiftUI
import SoyBeanCore

@main
struct SoyBeanPlayGroundApp: App {
    @State var isAnimating: Bool = true
    
    init() {
        print("등록된 폰트: \(Font.registerFonts())")
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView(tabSelection: .constant(.first))
                .onAppear(perform: {
                    let checkText = "안녕!"
                    print(RegExpUtil.evaluate(type: .email, compareWith: checkText))
                })
        }
    }
}
