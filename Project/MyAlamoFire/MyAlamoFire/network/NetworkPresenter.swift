//
//  NetworkPresenter.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2022/06/21.
//

import Foundation
import Alamofire

class NetworkPresenter {
    public func getPostWithNumber(postNumber: Int, completion: @escaping (ResponsePosts?, Any?) -> Void) {
        let requestPosts = NetworkClient.requestGet(url: "posts/\(postNumber)")
        
        DataParser.parseWithDecodable(request: requestPosts, type: ResponsePosts().self) { response, error in
            if let error = error {
                if let error = error as? Error {
                    completion(nil, "네트워크 상태가 불안정합니다. \n\n\(error.localizedDescription)")
                } else {
                    completion(nil, error)
                }
                
                return
            }
            
            guard
                let response = response
            else {
                completion(nil, "게시물 조회에 실패했습니다. response is nil")
                return
            }
            
            completion(response, nil)
        }
    }
    
    /// 광고 정보 조회
    /// - Parameter request: 요청 Body
    public func showAdInfo(_ request: CommonShowAdInfoRequest) async -> (ResponseForAd?, String) {
        guard
            let requestDic = DataParser.objectToDictionary(object: request)
        else {
            return (nil, "요청 객체 파싱 실패...")
        }
        
        let request = NetworkClient.requestPost(params: requestDic, url: "/showAdInfo")
        let (response, error) = await DataParser.parse(request: request, type: ResponseForAd.self)
        
        guard let response = response else {
            if let error = error {
                return (nil, error.localizedDescription)
            } else {
                return (nil, "광고 정보 조회 실패")
            }
        }
        
        switch response.resCode {
        case .success:
            return (response, "")
            
        case .failure:
            return (nil, response.resMsg ?? "응답 메시지 없음")
            
        default:
            return (nil, response.resMsg ?? "응답 메시지 없음")
        }
    }
}
