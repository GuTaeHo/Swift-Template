import SwiftUI
import SoyBeanCore
import SoyBeanUI

public struct MainView: View {
    @Binding var isAnimating: Bool

    public var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("Hello, World!")
                .font(.custom(.bold700, size: 24))
                .padding()
                .onTapGesture {
                    
                }
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.2), value: isAnimating)
            LongPressView()
                .contentShape(Rectangle())
        }
    }
}

#Preview {
    MainView(isAnimating: .constant(true))
        .loadCustomFontsForXcodePreviews()
}
