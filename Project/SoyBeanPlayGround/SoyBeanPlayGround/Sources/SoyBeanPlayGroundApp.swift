import SwiftUI

@main
struct SoyBeanPlayGroundApp: App {
    @State var isAnimating: Bool = true
    
    var body: some Scene {
        WindowGroup {
            MainView(isAnimating: $isAnimating)
        }
    }
}
