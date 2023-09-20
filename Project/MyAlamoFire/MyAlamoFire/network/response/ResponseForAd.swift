//
//  ResponseForAd.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2023/09/20.
//

import Foundation


struct ResponseForAd: Codable {
    enum Result: Int {
        case success = 0
        case failure = 98
    }
    var adInfo: [Advertisement]?
    /// 자동 전환(롤링) 속도
    var rollingNum: Int?
    /// 노출 영역 코드
    private var _showCode: Int?
    var showCode: CommonShowAdInfoRequest.ShowType? {
        get { return CommonShowAdInfoRequest.ShowType(rawValue: _showCode ?? -1 ) }
        set { _showCode = newValue?.rawValue }
    }
    
    /// 서버 결과 코드 (0: 성공, 98: 실패)
    private var _resCode: Int?
    var resCode: Result? {
        get { return Result(rawValue: _resCode ?? -1) }
        set { _resCode = newValue?.rawValue }
    }
    
    /// 서버 결과 메시지
    var resMsg: String?
    
    enum CodingKeys: String, CodingKey {
        case adInfo = "ad_info"
        case rollingNum = "rolling_num"
        case _showCode = "show_code"
        case _resCode = "res_code"
        case resMsg = "res_msg"
    }
}
