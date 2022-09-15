//
//  DeviceManager.swift
//  MySnapKit
//
//  Created by 구태호 on 2022/07/12.
//

import Foundation
import DeviceKit

class DeviceManager {
    static let shared: DeviceManager = DeviceManager()
    
    public enum DeviceGroup {
        case w320
        case w375
        case w390
        case w414
        case w428
        case iPhoneXSeries
        case iPhoneSeries
        case iPhoneSESeries
        public var rawValue: [Device] {
            switch self {
            case .w320:
                return [.iPhoneSE]
            case .w375:
                return [.iPhone6, .iPhone6s, .iPhone7, .iPhone8, .iPhoneSE2, .iPhoneX, .iPhoneXS, .iPhone11Pro, .iPhone12Mini]
            case .w390:
                return [.iPhone12, .iPhone12Pro]
            case .w414:
                return [.iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus, .iPhoneXR, .iPhoneXSMax, .iPhone11, .iPhone11ProMax]
            case .w428:
                return [.iPhone12ProMax]
                
            case .iPhoneXSeries:
                return Device.allDevicesWithSensorHousing
            case .iPhoneSeries:
                return [.iPhone6, .iPhone6s, .iPhone7, .iPhone8]
            case .iPhoneSESeries:
                return [.iPhoneSE, .iPhoneSE2]
            }
        }
    }
    
    func isWidth320() -> Bool {
        return Device.current.isOneOf(DeviceGroup.w320.rawValue)
    }
    
    func isWidth375() -> Bool {
        return Device.current.isOneOf(DeviceGroup.w375.rawValue)
    }
    
    func isWidth390() -> Bool {
        return Device.current.isOneOf(DeviceGroup.w390.rawValue)
    }
    
    func isWidth414() -> Bool {
        return Device.current.isOneOf(DeviceGroup.w414.rawValue)
    }
    
    func isWidth428() -> Bool {
        return Device.current.isOneOf(DeviceGroup.w428.rawValue)
    }
    
    func isXSeries() -> Bool {
        return Device.current.isOneOf(DeviceGroup.iPhoneXSeries.rawValue)
    }
    
    func isNormalSeries() -> Bool {
        return Device.current.isOneOf(DeviceGroup.iPhoneSeries.rawValue)
    }
    
    func isSESeries() -> Bool {
        return Device.current.isOneOf(DeviceGroup.iPhoneSESeries.rawValue)
    }
}

