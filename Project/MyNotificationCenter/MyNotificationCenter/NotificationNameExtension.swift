//
//  NotificationNameExtension.swift
//  MyNotificationCenter
//
//  Created by 구태호 on 2022/09/29.
//

import Foundation

// MARK: 관측할 Notification의 이름을 extension에 정의하면 깔끔하게 노티 이름을 관리 및 사용할 수 있음
extension Notification.Name {
    /// 사용자가 입력한 메시지를 송, 수신하기 위한 이름(식별자)
    static let sendTextData = Notification.Name("sendTextData")
    static let methodCallTest = Notification.Name("methodCallTest")
}
