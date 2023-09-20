//
//  Advertisement.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2023/09/20.
//


import Foundation


struct Advertisement: Codable {
    /// 광고 코드
    var adCode: Int?
    /// 광고 제목
    var adTitle: String?
    /// 서비스 코드
    private var _serviceCode: Int?
    var serviceCode: CommonShowAdInfoRequest.ServiceType? {
        get { return CommonShowAdInfoRequest.ServiceType(rawValue: _serviceCode ?? -1 ) }
        set { _serviceCode = newValue?.rawValue }
    }
    /// 광고 시작 일시
    var startDate: String?
    /// 광고 종료 일시
    var endDate: String?
    /// 이미지 URL 1
    var imgUrl: String?
    /// 이미지 URL 2
    var imgUrl2: String?
    /// 선택 시 이동할 URL
    var showImgUrl: String?
    
    enum ShowType: String {
        case banner = "B"
        case video = "V"
    }
    /// 표시 형태
    /// - Note: 배너: B / 동영상: V
    private var _showType: String?
    var showType: ShowType? {
        get { return ShowType(rawValue: _showType ?? "" ) }
        set { _showType = newValue?.rawValue }
    }
    /// 서비스 지역
    var serviceArea: String?
    
    enum CodingKeys: String, CodingKey {
        case adCode = "ad_code"
        case adTitle = "ad_title"
        case _serviceCode = "service_code"
        case startDate = "start_date"
        case endDate = "end_date"
        case imgUrl = "img_url"
        case imgUrl2 = "img_url2"
        case showImgUrl = "show_img_url"
        case _showType = "show_type"
        case serviceArea = "service_area"
    }
}
