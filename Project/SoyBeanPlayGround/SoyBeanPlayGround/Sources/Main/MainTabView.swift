import SwiftUI
import SoyBeanCore
import SoyBeanUI

public struct MainTabView: View {
    enum TabStatus: String {
        case first = "first"
        case second = "second"
        case third = "example@example.com"
    }
    
    @State private var tab3Title = "Third"
    @State private var badgeCount = 0
    @Binding var tabSelection: TabStatus
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    public var body: some View {
        TabView(selection: $tabSelection) {
            FirstView()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                }
                .tag(TabStatus.first)
            SecondView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
                .tag(TabStatus.second)
            ThirdView(badgeCount: $badgeCount)
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text(tab3Title)
                }
                .tag(TabStatus.third)
                .badge(badgeCount)
//                .onReceive(timer) { _ in
//                    badgeCount += 1
//                }
        }
    }
}

#Preview {
    MainTabView(tabSelection: .constant(.first))
}
