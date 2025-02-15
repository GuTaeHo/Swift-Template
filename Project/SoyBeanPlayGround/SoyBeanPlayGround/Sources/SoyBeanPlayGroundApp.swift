import SwiftUI

@main
struct SoyBeanPlayGroundApp: App {
    @State var isAnimating: Bool = true
    
    init() {
        print("등록된 폰트: \(UIFont.registerFonts())")
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(isAnimating: $isAnimating)
        }
    }
}
