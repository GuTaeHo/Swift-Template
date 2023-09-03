//
//  NetworkError.swift
//  MyAwaitAsync
//
//  Created by 구태호 on 2023/07/30.
//

import Foundation

/**
    서버와 통신에서 반드시 발생하는 에러를
    사용자 정의 에러를 만들어 처리할 수 있다.
 */
enum NetworkError: Error {
    case jsonParseError
    case notCertificate
    case tokenExpired
    case notFoundUser
    case invalidPassword
    case clientError(message: String?)
}
