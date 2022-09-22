//
//  SocketIOManager.swift
//  MyWebSocket
//
//  Created by 구태호 on 2022/07/08.
//

import Foundation
import SocketIO

/*
class SocketIOManager {

    static let shared = SocketIOManager()
    var socket: SocketIOClient!

    let manager = SocketManager(socketURL: URL(string: "http://192.168.101.204:3000")!, config: [.log(true), .compress])

    private init() {
        socket = manager.defaultSocket
    }

    func connectSocket(completion: @escaping(Bool) -> () ) {
        disconnectSocket()
        socket.on(clientEvent: .connect) {[weak self] (data, ack) in
            print("socket connected")
            self?.socket.removeAllHandlers()
            completion(true)
        }
        socket.connect()
    }

    func disconnectSocket() {
        socket.removeAllHandlers()
        socket.disconnect()
        print("socket Disconnected")
    }

    func checkConnection() -> Bool {
        if socket.manager?.status == .connected {
            return true
        }
        return false

    }

    enum Events {

        case search

        var emitterName: String {
            switch self {
            case .searchTags:
                return "emt_search_tags"
            }
        }

        var listenerName: String {
            switch self {
            case .search:
                return "filtered_tags"
            }
        }

        func emit(params: [String : Any]) {
            SocketIOManager.shared.socket.emit(emitterName, params)
        }

        func listen(completion: @escaping (Any) -> Void) {
            SocketIOManager.shared.socket.on(listnerName) { (response, emitter) in
                completion(response)
            }
        }

        func off() {
            SocketIOManager.shared.socket.off(listnerName)
        }
    }
}
 */
