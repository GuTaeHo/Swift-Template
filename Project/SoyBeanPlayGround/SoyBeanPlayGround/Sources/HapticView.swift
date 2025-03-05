//
//  HapticView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 3/5/25.
//

import SwiftUI
import SoyBeanUtil


struct HapticView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                  Button("impact light") {
                      HapticManager.shared.start(.impact(.light))
                  }
                  Button("impact medium") {
                      HapticManager.shared.start(.impact(.medium))
                  }
                  Button("impact heavy") {
                      HapticManager.shared.start(.impact(.heavy))
                  }
                  Button("impact rigid") {
                      HapticManager.shared.start(.impact(.rigid))
                  }
                  Button("impact soft") {
                      HapticManager.shared.start(.impact(.soft))
                  }
              }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button("notification error") {
                        HapticManager.shared.start(.notification(.error))
                    }
                    Button("notification success") {
                        HapticManager.shared.start(.notification(.success))
                    }
                    Button("notification warning") {
                        HapticManager.shared.start(.notification(.warning))
                    }
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button("selection") {
                        HapticManager.shared.start(.selection)
                    }
                }
            }
        }
    }
}


#Preview {
    HapticView()
}
