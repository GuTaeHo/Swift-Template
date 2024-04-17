//
//  AppDelegate+.swift
//  MyGoogleSignIn
//
//  Created by 구태호 on 4/8/24.
//

import UIKit


extension UIApplication {
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    static let rootViewController = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .last { $0.isKeyWindow }?
        .rootViewController
}
