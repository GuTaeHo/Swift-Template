import SwiftUI
import SoyBeanUI
import SoyBeanCore

@main
struct SoyBeanPlayGroundApp: App {
    init() {
        print("등록된 폰트: \(Font.registerFonts())")
        Log.debug("Hello, Debug!")
        Log.info("Hello, Info!")
        print("앱 명: \(Bundle.main.appName)")
        print("앱 번들: \(Bundle.main.appBundleID)")
        print("앱 버전: \(Bundle.main.appVersion)")
        print("앱 빌드 번호: \(Bundle.main.appBuildNumber)")
        print("앱 빌드 환경: \(Bundle.main.appInstallEnvironment.name)")
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    NavigationLink("롱프레스 뷰", destination: LongPressView())
                    NavigationLink("햅틱 뷰", destination: HapticView())
                    NavigationLink("숫자 애니매이션 카운트 뷰", destination: NumberAnimationView())
                    NavigationLink("SDWebImageView", destination: GIFImageTestView())
                }
                .navigationTitle("메인 뷰")
            }
        }
    }
}
