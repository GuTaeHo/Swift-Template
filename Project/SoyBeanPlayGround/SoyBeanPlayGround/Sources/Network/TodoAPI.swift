//
//  TodoAPI.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 6/14/25.
//

import Foundation
import Moya


enum TodoAPI {
    case getTodo
}

extension TodoAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .getTodo:
            return "/todos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
