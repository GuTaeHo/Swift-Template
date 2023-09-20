//
//  AdNetworkClientForIgnoreSSL.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2023/09/20.
//

import Foundation


class AdNetworkClientForIgnoreSSL: NSObject {
    let baseUrl = "https://ad-api.isdata.kr:31003"
    
    func requestAd(url: String, params: CommonShowAdInfoRequest?) async -> (ResponseForAd?, String?) {
        guard
            let params = params,
            let jsonDic = DataParser.objectToDictionary(object: params),
            let jsonObj = try? JSONSerialization.data(withJSONObject: jsonDic)
        else { return (nil, "요청 Body 가 누락되었습니다.") }
        
        
        var urlRequest = URLRequest(url: URL(string: baseUrl + url)!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonObj
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        guard let (data, response) = try? await session.data(for: urlRequest) else {
            return (nil, "요청 실패")
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return (nil, "status is not 200")
        }
        
        dump(httpResponse.debugDescription)
        
        if let decodedData = try? JSONDecoder().decode(ResponseForAd.self, from: data) {
            return (decodedData, nil)
        } else {
            return (nil, "파싱 에러")
        }
    }
}
