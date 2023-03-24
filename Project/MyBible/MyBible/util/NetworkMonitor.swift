//
//  NetworkMonitor.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/21.
//

import Network


class NetworkMonitor {
    enum NetworkConnectStatus: String {
        case wifi = "와이파이"
        case cellular = "셀룰러"
        case ethernet = "이더넷"
        case notConnected = "연결안됨"
    }
    
    let monitor = NWPathMonitor()
    
    /// 네트워크 변경 사항 감지
    func startMonitoring(networkStatusChangeClosure: @escaping (NetworkConnectStatus) -> ()) {
        monitor.start(queue: DispatchQueue.global())
//        monitor.pathUpdateHandler = { path in
//            DispatchQueue.main.async {
//                if path.status == .satisfied {
//                    if path.usesInterfaceType(.wifi) {
//                        networkStatusChangeClosure(.wifi)
//                    } else if path.usesInterfaceType(.cellular) {
//                        networkStatusChangeClosure(.cellular)
//                    } else if path.usesInterfaceType(.wiredEthernet) {
//                        networkStatusChangeClosure(.ethernet)
//                    }
//                } else {
//                    networkStatusChangeClosure(.notConnected)
//                }
//            }
//        }
    }
            
    func stopMonitoring() {
        monitor.cancel()
    }
}
