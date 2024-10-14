import SwiftUI
import SoyBeanCore
import SoyBeanUI

public struct MainTabView: View {
    let core = SoyBeanCoreTest()
    let ui = SoyBeanUITest()
    
    public var body: some View {
        TabView {
            Text("The First Tab")
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                }
            Text("Another Tab")
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
            Text("The Last Tab")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third")
                }
                .badge(10)
        }
        .font(.headline)
    }
}

#Preview {
    MainTabView()
}
