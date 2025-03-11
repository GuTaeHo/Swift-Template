import SwiftUI
import SoyBeanUI
import SoyBeanCore

@main
struct SoyBeanPlayGroundApp: App {
    init() {
        _ = Font.registerFonts()
        print("등록된 폰트: \(Font.registerFonts())")
        print("로그 테스트: \(Log.debug("Hello, World!"))")
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
