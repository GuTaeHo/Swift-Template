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
}
