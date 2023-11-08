//
//  OSLog+.swift
//  MyOSLog
//
//  Created by 구태호 on 11/8/23.
//

import OSLog


extension OSLog {
    private static let subSystem = Bundle.main.bundleIdentifier!
    
    static let ui = OSLog(subsystem: subSystem, category: "UI")
    static let network = OSLog(subsystem: subSystem, category: "Network")
    static let `deinit` = OSLog(subsystem: subSystem, category: "Deinit")
}
