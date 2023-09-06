//
//  Response.swift
//  MyAwaitAsync
//
//  Created by 구태호 on 2023/07/30.
//

import Foundation


struct Response<T: Codable>: Codable {
    private var _code: Int?
    var code: CodeType? {
        get {
            if let _code = _code {
                return Response.CodeType(rawValue: _code)
            }
            
            return nil
        }
        
        set {
            _code = newValue?.rawValue
        }
    }
    var message: String?
    var result: T?
    
    init(_code: Int? = nil, message: String? = nil, result: T? = nil) {
        self._code = _code
        self.message = message
        self.result = result
    }
    
    enum CodeType: Int {
        case success = 0
        case failure = -1
        case parseFailure = -999
    }
    
    enum CodingKeys: String, CodingKey {
        case _code = "code"
        case message
        case result
    }
    
    /// 서버 사양이 변경되어 JSON 형태가 변경된 경우 `keyNotFound, typeMismatch 에러`가 발생할 가능성이 있다.
    /// 이 경우 init(from:) 메소드를 정의하여 예외처리를 진행해주면 된다.
    /**
     만약 Response.message 이 Int로 변경된 경우 (예외처리가 되지않은 경우에) `typeMismatch` 오류가 발생하지만,
     init(from:) 처리가 되어있다면 해당 프로퍼티에만 nil 이 할당되게된다.
     */
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._code = (try? container.decode(Int.self, forKey: ._code)) ?? CodeType.parseFailure.rawValue
        self.message = (try? container.decode(String.self, forKey: .message)) ?? ""
        self.result = try? container.decode(T.self, forKey: .result)
    }
}
