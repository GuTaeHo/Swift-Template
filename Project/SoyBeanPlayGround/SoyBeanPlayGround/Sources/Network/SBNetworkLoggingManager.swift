//
//  SBNetworkLoggingManager.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 6/14/25.
//

import Foundation

public final class SBNetworkLoggingManager {
    public static let shared = SBNetworkLoggingManager()
    private var requests: [URLRequest] = []
    
    private init() {
        SBURLProtocol.shared.delegate = self
    }
    
    private enum Status {
        case start
        case stop
        case pause
    }
    
    private var status: Status = .stop
    
    /// 로깅을 시작합니다.
    public func start() {
        status = .start
    }
    
    /// 로깅을 종료합니다.
    /// - Note: 기존
    public func stop() {
        status = .stop
    }
    
    /// 로깅을 일시중지합니다.
    public func pause() {
        status = .pause
        requests = .init()
    }
    
    public func requestList() -> [URLRequest] {
        return requests
    }
    
    public func configuredSession() -> URLSession {
        let config = URLSessionConfiguration.default
        if status == .start {
            config.protocolClasses = [SBURLProtocol.self]
        }
        return URLSession(configuration: config)
    }
}

extension SBNetworkLoggingManager: SBURLProtocol.Delegate {
    func didReceive(request: URLRequest) {
    }
}
