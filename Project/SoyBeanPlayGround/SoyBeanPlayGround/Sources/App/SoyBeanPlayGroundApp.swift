import SwiftUI
import SoyBeanCore
import SoyBeanUI
import netfox
import Pulse

@main
struct SoyBeanPlayGroundApp: App {
    init() {
        print("폰트 등록: \(Font.registerFonts())")
        Log.debug("Hello, Debug!")
        Log.info("Hello, Info!")
        print("앱 명: \(Bundle.main.appName)")
        print("앱 번들: \(Bundle.main.appBundleID)")
        print("앱 버전: \(Bundle.main.appVersion)")
        print("앱 빌드 번호: \(Bundle.main.appBuildNumber)")
        print("앱 빌드 환경: \(Bundle.main.appInstallEnvironment.name)")
        // SoyBean > URLSession 캡처 활성화
        SBNetworkLoggingManager.shared.start()
        
        #if DEBUG
        // netfox > URLSession 캡처 활성화
        NFX.sharedInstance().start()
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    NavigationLink("롱프레스 뷰", destination: LongPressView())
                    NavigationLink("햅틱 뷰", destination: HapticView())
                    NavigationLink("숫자 애니매이션 카운트 뷰", destination: NumberAnimationView())
                    NavigationLink("SDWebImageView", destination: GIFImageTestView())
                    NavigationLink("SwiftUI 에서 UIKit 뷰 사용", destination: UIKitViewOnSwiftUIView())
                    NavigationLink("KeyChainView", destination: KeyChainView())
                    NavigationLink("UserDefaultsAnalyzerView", destination: UserDefaultsAnalyzerView())
                    NavigationLink("NetworkLoggingView", destination: NetworkLoggingView())
                }
                .navigationTitle("SoyBean Playground")
            }
            .onAppear {
                // Pulse > URLSession 캡처 활성화
                URLSessionProxyDelegate.enableAutomaticRegistration()
            }
        }
    }
}
