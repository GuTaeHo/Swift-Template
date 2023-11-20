//
//  StoryboardInstantiable.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 11/20/23.
//

import UIKit


protocol StoryboardInstantiable where Self: UIViewController {
    static func instantiate(on: String, creator: ((NSCoder) -> Self?)?) -> Self
}

extension StoryboardInstantiable {
    static func instantiate(on: String, creator: ((NSCoder) -> Self?)?) -> Self {
        let storyboard = UIStoryboard(name: on, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: Self.className, creator: creator)
        return viewController
    }
}

/**
 - 구현하는 쪽(UIViewController) 에서, StoryboardInstantiable 채택
 1. init?(coder: NSCoder, name: String) {
        self.name = name
        super.init(coder: coder)
    }
 2. @available(\*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("...")
    }
 
 - 전달(주입)하는 쪽에서
 1. let vc = TestViewController.instantiate(on: "storyboardName") {
        TestViewController(coder: $0, name: "전달될 이름")
    }
 */
