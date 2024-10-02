//
//  SocketIOManager.swift
//  MyWebSocket
//
//  Created by 구태호 on 2022/07/08.
//


import Foundation
import SocketIO
import UIKit
import Combine


class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    
    var manager: SocketManager?
    var socket: SocketIOClient?
    
    /// 소켓 초기화
    func initSocketIOClient() {
        
        /// `B`earer 대문자
        let bearerToken = "Bearer "
        let guildCode = ""
        
        manager = SocketManager(socketURL: URL(string: "")!)
        manager?.config = SocketIOClientConfiguration(
                    arrayLiteral: .compress,
                    .extraHeaders(["Authorization": bearerToken]),
                    .connectParams(["guildCode":guildCode]),
                    .path(""),
                    .forceWebsockets(true)
        )
                
        socket = manager?.socket(forNamespace: "/guild")

        // 서버와 연결 된 후 호출
        socket?.on(clientEvent: .connect) { data, ack in
        }
        
        // 서버로 부터 메시지 받으면 호출
        socket?.on("callback") { data, ack in
        }
        
        // 서버와 연결 해제 시 호출
        socket?.on(clientEvent: .disconnect) { data, ack in
        }
        
        socket?.on(clientEvent: .reconnectAttempt) { data, ack in
        }
        
        socket?.connect()
    }
    
    private override init() {}
}
