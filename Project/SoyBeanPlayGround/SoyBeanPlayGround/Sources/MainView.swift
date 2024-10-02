import SwiftUI
import SoyBeanCore
import SoyBeanUI

public struct MainView: View {
    let core = SoyBeanCoreTest()
    let ui = SoyBeanUITest()
    @Binding var isAnimating: Bool

    public var body: some View {
        Text("Hello, World!")
            .padding().onTapGesture {
                core.coreTest()
                ui.test()
            }.animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.2), value: isAnimating)
    }
}

#Preview {
    MainView(isAnimating: .constant(true))
}
