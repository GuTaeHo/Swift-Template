//
//  LocalFileManager.swift
//  MyFileManager
//
//  Created by 구태호 on 1/25/24.
//

import Foundation

/// 로컬 디렉토리 & 파일 관리 매니저
class LocalFileManager {
    static let shared = LocalFileManager()
    
    enum EntityType {
        case file
        case directory
    }
    
    enum FileType: String {
        case txt
    }
    
    private let fileManager = FileManager.default
    
    /// 도큐멘트 디렉토리 위치 반환
    var rootUrl: URL? {
        get { fileManager.urls(for: .documentDirectory, in: .userDomainMask).first }
    }
    
    /// 경로의 모든 엔티티 반환
    /// - Parameters:
    ///     - path: 파일을 찾을 경로
    func entities(at path: URL?) -> [String]? {
        guard let path = path else { return nil }
        
        return try? fileManager.contentsOfDirectory(atPath: path.absoluteString)
    }
    
    /// 디렉토리 생성
    /// - Parameters:
    ///     - title: 디렉토리 명
    /// - Important: 동일한 명의 디렉토리가 있을경우 생성하지 않음.
    /// - Returns: 생성에 실패할 경우 `false` 를 반환함.
    @discardableResult
    func makeDiretory(title: String) -> Bool {
        guard let path = rootUrl else { return false }
        guard let _ = try? fileManager.createDirectory(at: path, withIntermediateDirectories: false) else {
            return false
        }
        
        return true
    }
    
    /// 파일 생성
    /// - Parameters:
    ///     - directroyPath: 파일이 저장될 디렉토리 경로
    ///     - title: 파일 명
    ///     - contents: 파일 내용
    ///     - type: 파일 확장자
    /// - Important: 동일한 명의 파일이 있을경우 생성하지 않음.
    /// - Returns: 생성에 실패할 경우 `false` 를 반환함.
    @discardableResult
    func makeFile(at directroyPath: URL?, title: String, contents: String, type: FileType) -> Bool {
        guard let directoryPath = directroyPath else { return false }
        let url = directoryPath.appendingPathComponent("\(title).\(type.rawValue)")
        
        guard let _ = try? contents.write(to: url, atomically: false, encoding: .utf8) else {
            return false
        }
        return true
    }
    
    private init() { }
}

extension FileManager {
    func directoryExists(atUrl url: URL) -> Bool {
        var isDirectory: ObjCBool = false
        let exists = self.fileExists(atPath: url.path, isDirectory:&isDirectory)
        return exists && isDirectory.boolValue
    }
}
