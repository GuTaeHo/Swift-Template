//
//  Version.swift
//  MyAwaitAsync
//
//  Created by 구태호 on 2023/07/30.
//

import Foundation


struct Version: Codable {
    var iosMinVersion: String?
    var iosCurrentVersion: String?
    /// 앱 진입 가능 여부
    var isAccessible: Bool = false
    /// 공지사항 표시 여부
    var isNoticeShow: Bool = false
    var noticeTitle: String?
    var noticeContent: String?
    /// 공지사항 (?) 클릭 시 이동할 URL
    var noticeUrl: String?
    /// 공지 배경 색상 (ex: #000000)
    var noticeColor: String?
    /// API 서버 요청 URL
    /// - note: 앱 버전에 따라 (서버에서) 다른 값을 반환함
    var apiServerAccessUrl: String?
    /// 소켓 서버 연결 URL
    var socketServerAccessUrl: String?
    /// 앱 스토어 도메인
    var appStoreUrl: String?
}
