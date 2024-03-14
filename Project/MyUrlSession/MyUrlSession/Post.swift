//
//  Post.swift
//  MyUrlSession
//
//  Created by 구태호 on 3/6/24.
//

import Foundation

/**
 Codable 을 채택한 DTO 는 외부표현(직렬화라고도 함)으로 변환하거나, 내부표현(역직렬화) 으로 변환할 수 있다.
 외부 표현으로 변환 가능한 객체는 Encodable 을 채택했다고 할 수 있으며,
 내부 표현으로 변환 가능한 객체는 Decodable 을 채택했다고 볼 수 있다.
 
 
 
 
 참고
 - https://ko.wikipedia.org/wiki/%EC%99%B8%EB%B6%80_%EB%8D%B0%EC%9D%B4%ED%84%B0_%ED%91%9C%ED%98%84 (외부 데이터 표현)
 - https://minsone.github.io/programming/swift-codable-and-exceptions-extension (JSON 디코딩)
 */
struct Post: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
    // MARK: 서버에서 해당하는 필드를 주지않을 때, 옵셔널로 선언되지않은 필드가 있다면 무조건 파싱에 실패한다.
    // MARK: 필드를 옵셔널로 선언하면 파싱에 성공하고, 해당 필드의 값은 nil 로 초기화된다.
    var _hasIndicator: Bool
    
    // 모든 필드가 옵셔널로 선언되면 사용할 때 언래핑을 항상 진행해야하므로 불편하다.
    // 이를 해결하기 위해 디코딩 될 때 필드에 기본값을 넣어주는 작업을 할 수 있는데,
    // 디코딩 시 (서버에서 해당필드를 주지 않았을 경우 & 필드의 타입이 다른경우) 필드를 기본값으로 초기화 하고 파싱에 성공시키려면 init(from:) 을 구현해주어야한다.
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.postId = (try? container.decode(Int.self, forKey: .postId)) ?? -1
        self.id = (try? container.decode(Int.self, forKey: .id)) ?? -1
        self.name = (try? container.decode(String.self, forKey: .name)) ?? "없음"
        self.email = (try? container.decode(String.self, forKey: .email)) ?? "없음"
        self.body = (try? container.decode(String.self, forKey: .body)) ?? "없음"
        self._hasIndicator = (try? container.decode(Bool.self, forKey: ._hasIndicator)) ?? false
    }
}
