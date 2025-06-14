//
//  NetworkLoggingView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 6/14/25.
//

import SwiftUI
import Alamofire
import Moya


struct NetworkLoggingView: View {
    let provider = MoyaProvider<TodoAPI>()
    
    var body: some View {
        Text("NetworkLoggingView")
    }
    
    func fetchTODOWitAlamofire() -> [Todo] {
        let url = "https://jsonplaceholder.typicode.com/todos/1"
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.protocolClasses = [SBURLProtocol.self]

        let session = Session(configuration: configuration)
        
        
        AF.request(url)
            .validate()
            .responseDecodable(of: Todo.self) { response in
                switch response.result {
                case .success(let todo):
                    print("Todo:", todo)
                case .failure(let error):
                    print("Error:", error)
                }
            }
    }
    
    func fetchTodoWithMoya() {
        provider.request(.getTodo(id: 1)) { result in
            switch result {
            case .success(let response):
                do {
                    let todo = try JSONDecoder().decode(Todo.self, from: response.data)
                    print("Todo:", todo)
                } catch {
                    print("Decoding error:", error)
                }
            case .failure(let error):
                print("Network error:", error)
            }
        }
    }
}



