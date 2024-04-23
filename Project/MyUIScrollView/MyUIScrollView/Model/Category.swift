//
//  Category.swift
//  MyUIScrollView
//
//  Created by 구태호 on 2023/09/26.
//

import Foundation

struct Category: Hashable {
    var _identifier = UUID()
    var title: String
    var isShowDivide: Bool = false
}
