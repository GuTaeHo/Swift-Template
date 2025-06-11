//
//  HapticView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 3/5/25.
//

import SwiftUI
import SoyBeanUI



struct HapticView: View {
//    var hapticManager = HapticManager()
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Group {
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
                        .padding(.init(horizontal: 12, vertical: 6))
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        }
                        .clipShape(.capsule)
                    }
                    .padding(.init(horizontal: 12, vertical: 6))
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Group {
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
                        .padding(.init(horizontal: 12, vertical: 6))
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        }
                        .clipShape(.capsule)
                    }
                    .padding(.init(horizontal: 12, vertical: 6))
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Group {
                            Button("selection") {
                                HapticManager.shared.start(.selection)
                            }
                        }
                        .padding(.init(horizontal: 12, vertical: 6))
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        }
                        .clipShape(.capsule)
                    }
                    .padding(.init(horizontal: 12, vertical: 6))
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    Text("커스텀 햅틱")
                    HStack {
                        Group {
                            Button("뚜-둑!") {
//                                hapticManager.playCustomHaptic()
                            }
                        }
                        .padding(.init(horizontal: 12, vertical: 6))
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        }
                        .clipShape(.capsule)
                    }
                    .padding(.init(horizontal: 12, vertical: 6))
                }
            }
            .foregroundStyle(.white)
        }
        .shadow(color: .gray, radius: 5, x: 0, y: 5) // 배경만 그림자 적용
    }
}


#Preview {
    HapticView()
}



//class HapticManager {
//    private var engine: CHHapticEngine?
//
//    init() {
//        do {
//            engine = try CHHapticEngine()
//            try engine?.start()
//        } catch {
//            print("Haptic Engine 생성 실패: \(error.localizedDescription)")
//        }
//    }
//    
//    func playCustomHaptic() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//
//        var events = [CHHapticEvent]()
//
//        // 강한 진동 (intensity: 1.0, sharpness: 1.0)
//        let strongHaptic = CHHapticEvent(
//            eventType: .hapticTransient,
//            parameters: [
//                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
//                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
//            ],
//            relativeTime: 0
//        )
//
//        // 약한 진동 (intensity: 0.5, sharpness: 0.5)
//        let weakHaptic = CHHapticEvent(
//            eventType: .hapticTransient,
//            parameters: [
//                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
//                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
//            ],
//            relativeTime: 0.2
//        )
//
//        events.append(strongHaptic)
//        events.append(weakHaptic)
//
//        // 패턴 생성
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
//        } catch {
//            print("Haptic Pattern 실행 실패: \(error.localizedDescription)")
//        }
//    }
//}
