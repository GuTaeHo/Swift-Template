//
//  Todo.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 6/14/25.
//

struct Todo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
