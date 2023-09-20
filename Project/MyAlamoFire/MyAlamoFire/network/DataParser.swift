//
//  DataParser.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2022/06/21.
//

import Alamofire

/// 1. request에 대한 response를 JSON 형태로 획득
/// 2. 응답 결과 (성공 or 실패)를 분기
/// 3. 성공 시  JSONDecoder를 통해 파싱, model 형태에 맞게 콜백
class DataParser {
    /// (Async/Await) 지정된 타입에 맞게 응답을 파싱합니다.
    /// - Parameters:
    ///     - request: 요청 객체
    ///     - type: 파싱될 응답 형태에 대한 메타 타입
    public static func parse<T: Codable>(request: DataRequest, type: T.Type) async -> (T?, AFError?) {
        let dataTask = request.serializingDecodable(type)
        
        switch await dataTask.result {
        case .success(let value):
            return (value, nil)
            
        case .failure(let error):
            return (nil, error)
        }
    }
    
    public static func parseWithDecodable<T: Codable>(request: DataRequest, type: T, completion: @escaping (T?, Any?) -> Void) {
        request.responseDecodable(of: T.self) { response in
            /// DataResponse의 response 필드의 statusCode에는 URL 요청에 대한 서버의 HTTP Status Code 가 담겨 있음
            /// DataResponse의 result 필드와 조합하여 Status Code에 따라 분기처리가 가능함
            /// ex) 응답을 받았지만 URL에 해당하는 페이지가 없는 경우 [.success, 404]
            print("@@@ \(response.response?.statusCode ?? -999)")
            
            
            switch response.result {
                /// 서버와 통신이 성공했다면 value 인자를 통해 값이 넘어옴
            case .success(let value):
                print(value)
                /// AFError 클래스는 통신 실패관련 오류에 관한 정보를 포함하고 있음
                if value is AFError {
                    print(value)
                    completion(nil, value)
                    return
                }
                
                completion(value, nil)
                break
                
                /// 연결이 완전히 실패한 경우 error 인자를 통해 값이 넘어옴
            case .failure(let error):
                completion(nil, error)
                break
            }
        }
    }
    
    public static func objectToDictionary(object: Encodable) -> [String:Any]? {
        guard
            let data = object.convertToJson?.data(using: .utf8),
            let params = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else {
            return nil
        }
        return params
    }
}
