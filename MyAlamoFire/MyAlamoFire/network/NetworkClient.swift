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
}
