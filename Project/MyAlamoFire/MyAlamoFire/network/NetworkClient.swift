//
//  NetworkClient.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2022/06/21.
//

import Foundation
import Alamofire

class NetworkClient {
    private static var headers: HTTPHeaders?
    
    private static let DEBUG_URL = "https://jsonplaceholder.typicode.com"
    private static let RELEASE_URL = "https://jsonplaceholder.typicode.com"
    
    private static var baseUrl: String {
        get {
#if DEBUG
            return NetworkClient.DEBUG_URL
#else
            return NetworkClient.RELEASE_URL
#endif
        }
    }
    
    /*
     // MARK: URL 타입은 영문, 숫자, 몇몇 특수문자만 인코딩 가능,
     // MARK: 즉 한글같은 문자는 퍼센트 인코딩을 통해 URL 타입으로 인코딩 할 수 있음
     private static func url() -> URL {
     #if DEBUG
     URL(string: DEBUG_URL)!
     #else
     URL(string: RELEASE_URL)!
     #endif
     }
     */
    
    public static func requestGet(url: String) -> DataRequest {
        return AF.request("\(NetworkClient.baseUrl)/\(url)", method: .get,
                          headers: headers)
    }
    
    /// API 요청 URL 반환
    public static func getUrl() -> URL {
#if DEBUG
        URL(string: "URL")!
#else
        URL(string: "URL")!
#endif
    }
    
    /// 신뢰하는 서버(도메인)와 연결된 세션을 생성합니다.
    /// - Warning: SSL 인증이 되지 않았기 때문에 인증 방식을 우회하기 위해 사용.
    private static let session: Session = {
        let manager = ServerTrustManager(evaluators: ["도메인": DisabledTrustEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    
    public static func requestPost(params: Parameters? = nil, url: String) -> DataRequest {
        return AF.request("\(getUrl())/\(url)",
                               method: .post,
                               parameters: params,
                               encoding: JSONEncoding.default)
    }
}
