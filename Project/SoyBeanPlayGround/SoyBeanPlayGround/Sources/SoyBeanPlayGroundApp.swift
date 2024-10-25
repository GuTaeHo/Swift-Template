import SwiftUI
import SoyBeanCore

@main
struct SoyBeanPlayGroundApp: App {
    @State var isAnimating: Bool = true
    
    var body: some Scene {
        WindowGroup {
            MainTabView(tabSelection: .constant(.first))
                .onAppear(perform: {
                    let checkText = "안녕!"
                    print(checkText.evaluate(with: .onlyEnglishKoreanNumAnsSomeSpecialCharacter) ? "통과" : "실패")
                })
        }
    }
}
