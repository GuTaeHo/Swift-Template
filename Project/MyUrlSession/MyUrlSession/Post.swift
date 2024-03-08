//
//  Post.swift
//  MyUrlSession
//
//  Created by 구태호 on 3/6/24.
//

import Foundation

/**
 Codable 을 채택한 DTO 는 외부표현(직렬화라고도 함)으로 변환하거나, 내부표현(역직렬화) 으로 변환할 수 있다.
 
 
 
 참고
 - https://ko.wikipedia.org/wiki/%EC%99%B8%EB%B6%80_%EB%8D%B0%EC%9D%B4%ED%84%B0_%ED%91%9C%ED%98%84 (외부 데이터 표현)
 */
struct Post: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
    // MARK: 서버에서 해당하는 필드를 주지않을 때, 옵셔널로 선언되지않은 필드가 있다면 무조건 파싱에 실패한다.
    // MARK: 필드를 옵셔널로 선언하면 파싱에 성공하고, 해당 필드의 값은 nil 로 초기화된다.
    // var _hasIndicator: Bool = false
}
