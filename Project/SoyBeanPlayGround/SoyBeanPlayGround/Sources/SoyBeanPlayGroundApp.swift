import SwiftUI
import SoyBeanUI

@main
struct SoyBeanPlayGroundApp: App {
    init() {
        print("등록된 폰트: \(Font.registerFonts())")
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    NavigationLink("롱프레스 뷰", destination: LongPressView())
                    NavigationLink("햅틱 뷰", destination: HapticView())
                }
                .navigationTitle("메인 뷰")
            }
        }
    }
}
