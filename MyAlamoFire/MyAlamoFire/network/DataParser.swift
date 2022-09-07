//
//  DataParser.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2022/06/21.
//

import Foundation
import Alamofire

/// 1. request에 대한 response를 JSON 형태로 획득
/// 2. 응답 결과 (성공 or 실패)를 분기
/// 3. 성공 시  JSONDecoder를 통해 파싱, model 형태에 맞게 콜백
class DataParser {
    public static func parseWithDecodable<T: Codable>(request: DataRequest, type: T, completion: @escaping (T?, Any?) -> Void) {
        request.responseDecodable(of: T.self) { response in
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
    
    /*
    public static func parse<T: Codable>(request: DataRequest, data: T, completion: @escaping (T?, Any?) -> Void) {
        request.responseJSON { response in
            switch response.result {
            /// 서버와 통신이 성공했다면 value 인자를 통해 값이 넘어옴
            case .success(let value):
                /// AFError 클래스는 통신 실패관련 오류에 관한 정보를 포함하고 있음
                if value is AFError {
                    completion(nil, value)
                    return
                }
                
                /// AFDataResponse > DATA > T(model) 형태로 파싱
                /// 파싱에 실패할 가능성이 있기 때문에 do catch 문 사용
                do {
                    /// prettyPrinted > json을 출력할 때 공백 및 들여쓰기를 포함하여 출력
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    
                    /// jsonData를 Decodable 프로토콜을 준수한 model 클래스 형태로 디코딩
                    let data = try
                    JSONDecoder().decode(T.self, from: jsonData)
                    
                    completion(data, nil)
                } catch (let error) {
                    completion(nil, error)
                }
                break
                
            /// 연결이 완전히 실패한 경우 error 인자를 통해 값이 넘어옴
            case .failure(let error):
                completion(nil, error)
                break
            }
        }
    }
    */
}
