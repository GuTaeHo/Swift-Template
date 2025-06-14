//
//  SBNetworkLoggingManager.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 6/14/25.
//

import Foundation
import SoyBeanCore
import Combine


/**
 앱 내의 모든 `URLSession 기반` **HTTP/HTTPS 요청**을 가로채는 매니저.
 */
public final class SBNetworkLoggingManager {
    public static let shared = SBNetworkLoggingManager()
    
    /// 새로운 네트워크 로그가 생겼을 때 방출하는 퍼블리셔
    public var requestsPublisher: AnyPublisher<[URLRequest], Never>
    private var requestsSubject = CurrentValueSubject<[URLRequest], Never>([])
    
    private init() {
        requestsPublisher = requestsSubject.eraseToAnyPublisher()
        SBURLProtocol.delegate = self
    }
    
    private enum Status {
        case start
        case stop
        case pause
    }
    
    private var status: Status = .stop
    
    /**
     로깅을 시작합니다.
     
     - Warning: 운영환경 앱에서 포함되지 않도록
     **반드시** #if DEBUG 를 감싸서 사용해야합니다.
     */
    public func start() {
        if status != .start {
            status = .start
            statusChanged()
        }
    }
    
    /// 로깅을 종료합니다.
    /// - Note: 기존
    public func stop() {
        if status != .stop {
            status = .stop
            statusChanged()
        }
    }
    
    /// 로깅을 일시중지합니다.
    public func pause() {
        if status != .pause {
            status = .pause
            requestsSubject.send([])
            statusChanged()
        }
    }
    
    public func requestList() -> [URLRequest] {
        return requestsSubject.value
    }
    
    private func statusChanged() {
        if status == .start {
            if URLProtocol.registerClass(SBURLProtocol.self) {
                Log.info("네트워크 로깅 프로토콜 등록 성공")
            } else {
                Log.info("네트워크 로깅 프로토콜 등록 실패")
            }
        } else {
            URLProtocol.unregisterClass(SBURLProtocol.self)
            Log.info("네트워크 로깅 프로토콜 해제")
        }
    }
}

extension SBNetworkLoggingManager: SBURLProtocol.Delegate {
    func didReceive(request: URLRequest) {
        var requests = requestsSubject.value
        requests.append(request)
        self.requestsSubject.send(requests)
    }
}
