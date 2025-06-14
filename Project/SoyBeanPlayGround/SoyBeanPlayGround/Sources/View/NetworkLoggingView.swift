//
//  NetworkLoggingView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 6/14/25.
//

import Alamofire
import Moya
import SwiftUI
import Combine
import SoyBeanCore


let session = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 10
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    configuration.protocolClasses = [SBURLProtocol.self]
    
    let session = Session(configuration: configuration)
    return session
}()

struct NetworkLoggingView: View {
    
    let provider = MoyaProvider<TodoAPI>(session: session)
    
    @State private var todos: [Todo] = []
    @State private var loggingTodos: [URLRequest] = []
    
    var body: some View {
        Text("NetworkLoggingView")
        
        HStack {
            Button("from Alamofire") {
                fetchTODOWitAlamofire()
            }
            
            Button("from Alamofire") {
                fetchTodoWithMoya()
            }
        }
        
        ScrollView {
            Text("API 결과 리스트")
            LazyVStack(alignment: .leading) {
                ForEach(todos, id: \.self) {
                    Text($0.title)
                        .padding()
                }
            }
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        
        ScrollView {
            Text("API 로깅 리스트")
            LazyVStack(alignment: .leading) {
                ForEach(loggingTodos, id: \.self) { loggingTodo in
                    VStack(alignment: .leading) {
                        Text(loggingTodo.url?.absoluteString ?? "")
                        Text(loggingTodo.httpMethod ?? "")
                        Text("\(loggingTodo.httpBody?.toJSONDictionary ?? .init())")
                    }
                    .padding()
                }
            }
        }
        .onReceive(SBNetworkLoggingManager.shared.requestsPublisher.main) { result in
            loggingTodos = result
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
    }
    
    func fetchTODOWitAlamofire() {
        let url = "https://jsonplaceholder.typicode.com/todos"
        
        session.request(url)
            .validate()
            .responseDecodable(of: [Todo].self) { response in
                switch response.result {
                case .success(let todos):
                    self.todos = todos
                case .failure(_):
                    self.todos = []
                }
            }
    }
    
    func fetchTodoWithMoya() {
        provider.request(.getTodo) { result in
            switch result {
            case .success(let response):
                do {
                    let todos = try JSONDecoder().decode([Todo].self, from: response.data)
                    self.todos = todos
                } catch {
                    self.todos = []
                }
            case .failure(let error):
                self.todos = []
            }
        }
    }
}

#Preview {
    NetworkLoggingView()
}



