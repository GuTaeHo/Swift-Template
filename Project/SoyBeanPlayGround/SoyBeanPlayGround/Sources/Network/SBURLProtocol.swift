//
//  SBURLProtocol.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 6/14/25.
//

import Foundation



/**
 HTTP 요청을 대행하는 프로토콜.
 */
final class SBURLProtocol: URLProtocol {
    protocol Delegate: AnyObject {
        /// 위임된 Request 처리 시 호출
        func didReceive(request: URLRequest)
    }
    
    // 무한 루프 방지를 위한 키
    static let handledKey = "SBURLProtocolHandlerKey"
    
    static weak var delegate: SBURLProtocol.Delegate?
    
    private var customTask: URLSessionTask?

    // 이 요청을 처리할 것인지 여부 결정
    override class func canInit(with request: URLRequest) -> Bool {
        // 이미 처리한 요청이라면 무시
        if URLProtocol.property(forKey: handledKey, in: request) != nil {
            return false
        }
        
        return request.url?.scheme == "http" || request.url?.scheme == "https"
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    /**
     요청 인터셉트 후 처리
     
     Protocol 에 위임된 Request 를 실질적으로 처리하는 로직
     위임된 task 를 처리하고, 현재 Request 에 대한 정보를 저장해 중복 처리를 막음
     */
    override func startLoading() {
        let newRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        URLProtocol.setProperty(true, forKey: SBURLProtocol.handledKey, in: newRequest)
        SBURLProtocol.delegate?.didReceive(request: request)

        let session = URLSession(configuration: .default)
        customTask = session.dataTask(with: newRequest as URLRequest) { data, response, error in
            if let response = response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = data {
                self.client?.urlProtocol(self, didLoad: data)
            }
            if let error = error {
                self.client?.urlProtocol(self, didFailWithError: error)
            } else {
                self.client?.urlProtocolDidFinishLoading(self)
            }
        }
        customTask?.resume()
    }
    
    override func stopLoading() {
        customTask?.cancel()
    }
}
