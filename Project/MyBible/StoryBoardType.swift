//
//  StoryBoardType.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/26.
//

import Foundation

// MARK: CaseIterable 프로토콜을 채택한 enum 클래스는 모든 case에 대한 컬렉션을 제공할 수 있음
/**
 모든 스토리보드 생성 시, 편의성을 위해 아래에 스토리보드 명을 기입
 */
enum StoryBoardType: String, CaseIterable {
    case main = "Main"
}
