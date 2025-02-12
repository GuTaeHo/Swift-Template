import SwiftUI
import SoyBeanCore
import SoyBeanUI

public struct MainTabView: View {
    let core = SoyBeanCoreTest()
    let ui = SoyBeanUITest()
    enum TabStatus: String {
        case first = "first"
        case second = "second"
        case third = "example@example.com"
    }
    
    @State private var tab3Title = "Third"
    @State private var badgeCount = 0
    @Binding var tabSelection: TabStatus
    
    public var body: some View {
        TabView {
            Text("The First Tab")
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                }
                .tag(TabStatus.first)
            Text("Another Tab")
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
                .tag(TabStatus.second)
            Text("The Last Tab")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text(tab3Title)
                }
                .tag(TabStatus.third)
                .badge(badgeCount)
        }.onChange(of: tabSelection) { newValue in
            tab3Title = RegExpUtil.evaluate(type: .email, compareWith: newValue.rawValue) ? "이메일 O" : "이메일 X"
        }
    }
}

#Preview {
    MainTabView(tabSelection: .constant(.first))
}
