//
//  HapticUtil.swift
//  MyUIComponents
//
//  Created by 구태호 on 2022/08/30.
//

import Foundation
import UIKit

class HapticUtil {
    enum HapticType: String {
        // 알림 수준의 피드백
        case NOTIFICATION = "notification"
        // 경고 수준의 피드백
        case IMPACT = "impact"
    }
    
    enum HapticStyle: String {
        case HEAVY
        case MEDIUM
        case LIGHT
    }
    
    private static var notificationGenerator: UINotificationFeedbackGenerator?
    private static var impactGenerator: UIImpactFeedbackGenerator?
    
    /// 햅틱 피드백을 시작하기 전 미리 준비 시키는 단계 (권장 사항)
    /// - Parameters:
    /// - Parameter type: 햅틱 종류 지정 (NOTIFICATION - 알림, IMPACT - 경고)
    /// - Parameter power: 종류가 IMPACT 일 경우 세기 (heavy, medium, light)
    public static func prepare(type: HapticType = .NOTIFICATION, style: HapticStyle = .MEDIUM) {
        switch type {
        case .NOTIFICATION:
            notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator?.prepare()
            initNotificationGenerator(style: style)
            break
        case .IMPACT:
            initImpactGenerator(style: style)
            break
        }
    }
    
    private static func initNotificationGenerator(style: HapticStyle) {
        switch style {
        case .HEAVY:
            notificationGenerator?.notificationOccurred(.warning)
        case .MEDIUM:
            notificationGenerator?.notificationOccurred(.error)
        case .LIGHT:
            notificationGenerator?.notificationOccurred(.success)
        }
    }
    
    private static func initImpactGenerator(style: HapticStyle) {
        switch style {
        case .HEAVY:
            impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
            impactGenerator?.impactOccurred()
        case .MEDIUM:
            impactGenerator = UIImpactFeedbackGenerator(style: .medium)
            impactGenerator?.impactOccurred()
        case .LIGHT:
            impactGenerator = UIImpactFeedbackGenerator(style: .light)
            impactGenerator?.impactOccurred()
        }
    }
}
