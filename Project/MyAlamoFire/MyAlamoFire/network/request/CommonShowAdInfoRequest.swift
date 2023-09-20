//
//  CommonShowAdInfoRequest.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2023/09/20.
//

import Foundation


/// 광고 정보 API 요청 시 포함될 Body 정보
struct CommonShowAdInfoRequest: Codable {
    /// 서비스(프로젝트) 타입
    enum ServiceType: Int {
        case daeguro = 1
    }
    /// (표시될) 서비스 구분자
    /// - Note: 배달, 택시, 퀵 등
    private var _serviceCode: Int?
    var serviceCode: ServiceType? {
        get { return ServiceType(rawValue: _serviceCode ?? -1) }
        set { _serviceCode = newValue?.rawValue }
    }
    
    /// 표시(노출) 영역 타입
    enum ShowType: Int {
        case mainPopUp = 1
    }
    /// 노출 영역 구분자
    /// - Note: 메인, 배달 홈, 메뉴 상세 등
    private var _showCode: Int?
    var showCode: ShowType? {
        get { return ShowType(rawValue: _showCode ?? -1) }
        set { _showCode = newValue?.rawValue }
    }
    
    enum CodingKeys: String, CodingKey {
        case _serviceCode = "service_code"
        case _showCode = "show_code"
    }
    
    init(serviceCode: ServiceType? = nil, showCode: ShowType? = nil) {
        self._serviceCode = serviceCode?.rawValue ?? -1
        self._showCode = showCode?.rawValue ?? -1
    }
}
