//
//  Menu.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 11/21/23.
//

import Foundation


struct Menu {
    var name: String?
    var thumbNailUrl: String?
    var menuGroup: [MenuGroup]?
}

struct MenuGroup {
    var name: String?
    var summary: String?
    var options: [MenuOption]?
}

struct MenuOption {
    var name: String?
    var price: Int?
    var isSelected: Bool = false
}
