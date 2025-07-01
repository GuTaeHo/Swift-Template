//
//  UserDefaultsAnalyzer.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 7/1/25.
//

import Foundation

class UserDefaultsAnalyzer {
    
    /// UserDefaults에 저장된 모든 값들을 출력하고 총 사이즈를 반환
    static func analyzeUserDefaults() -> Double {
        let userDefaults = UserDefaults.standard
        let allKeys = userDefaults.dictionaryRepresentation()
        
        var totalSizeInBytes = 0
        
        print("=== UserDefaults 저장된 모든 값들 ===")
        print("총 키 개수: \(allKeys.count)")
        print("----------------------------------------")
        
        for (key, value) in allKeys {
            let valueSize = calculateSizeOfValue(value)
            totalSizeInBytes += valueSize
            
            print("키: \(key)")
            print("값: \(value)")
            print("타입: \(type(of: value))")
            print("사이즈: \(valueSize) bytes")
            print("----------------------------------------")
        }
        
        let totalSizeInKB = Double(totalSizeInBytes) / 1024.0
        
        print("=== 요약 ===")
        print("총 사이즈: \(totalSizeInBytes) bytes")
        print("총 사이즈: \(String(format: "%.6f", totalSizeInKB)) KB")
        
        return totalSizeInKB
    }
    
    /// 특정 값의 메모리 사이즈를 계산
    private static func calculateSizeOfValue(_ value: Any) -> Int {
        // NSKeyedArchiver를 사용하여 실제 저장 크기에 가까운 값을 계산
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            return data.count
        } catch {
            // NSKeyedArchiver가 실패하면 대안적 방법 사용
            return calculateAlternativeSize(value)
        }
    }
    
    /// 대안적 사이즈 계산 방법
    private static func calculateAlternativeSize(_ value: Any) -> Int {
        switch value {
        case let stringValue as String:
            return stringValue.utf8.count
        case let dataValue as Data:
            return dataValue.count
        case let numberValue as NSNumber:
            return MemoryLayout.size(ofValue: numberValue)
        case let arrayValue as [Any]:
            return arrayValue.reduce(0) { $0 + calculateSizeOfValue($1) }
        case let dictValue as [String: Any]:
            return dictValue.reduce(0) { result, pair in
                return result + pair.key.utf8.count + calculateSizeOfValue(pair.value)
            }
        case let boolValue as Bool:
            return MemoryLayout.size(ofValue: boolValue)
        case let intValue as Int:
            return MemoryLayout.size(ofValue: intValue)
        case let doubleValue as Double:
            return MemoryLayout.size(ofValue: doubleValue)
        default:
            // 기본적으로 문자열 표현의 크기 반환
            return String(describing: value).utf8.count
        }
    }
    
    /// 특정 키의 값만 조회
    static func getValueForKey(_ key: String) {
        let userDefaults = UserDefaults.standard
        let value = userDefaults.object(forKey: key)
        
        if let value = value {
            let size = calculateSizeOfValue(value)
            print("키: \(key)")
            print("값: \(value)")
            print("타입: \(type(of: value))")
            print("사이즈: \(size) bytes")
        } else {
            print("키 '\(key)'에 대한 값이 존재하지 않습니다.")
        }
    }
    
    /// UserDefaults 초기화 (주의: 모든 데이터가 삭제됩니다)
    static func clearAllUserDefaults() {
        let userDefaults = UserDefaults.standard
        let dictionary = userDefaults.dictionaryRepresentation()
        
        for key in dictionary.keys {
            userDefaults.removeObject(forKey: key)
        }
        
        userDefaults.synchronize()
        print("UserDefaults가 모두 초기화되었습니다.")
    }
}
