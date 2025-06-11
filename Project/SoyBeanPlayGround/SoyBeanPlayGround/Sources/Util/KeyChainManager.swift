//
//  KeyChainManager.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 6/11/25.
//

import Foundation
import Security


public final class KeychainManager {
    
    public static let shared = KeychainManager()
    
    private init() { }
    
    /// 저장
    /// - Note: 이미 key 가 존재할 경우, 삭제 후 저장
    @discardableResult
    public func save(_ value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        delete(forKey: key)
        
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    // 조회
    public func load(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : true,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return value
    }
    
    /// 수정
    @discardableResult
    public func update(_ value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key
        ]
        
        let attributesToUpdate: [String: Any] = [
            kSecValueData as String   : data
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        return status == errSecSuccess
    }
    
    /// 삭제
    @discardableResult
    public func delete(forKey key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    /// 전체 조회
    public func loadAll() -> [String: String] {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecReturnAttributes as String: true,
            kSecReturnData as String  : true,
            kSecMatchLimit as String  : kSecMatchLimitAll
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        var items: [String: String] = [:]
        
        if status == errSecSuccess, let array = result as? [[String: Any]] {
            for item in array {
                if let key = item[kSecAttrAccount as String] as? String,
                   let valueData = item[kSecValueData as String] as? Data,
                   let value = String(data: valueData, encoding: .utf8) {
                    items[key] = value
                }
            }
        }
        
        return items
    }
}
