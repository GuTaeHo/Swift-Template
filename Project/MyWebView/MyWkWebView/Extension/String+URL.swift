//
//  String+URL.swift
//  MyWebView
//
//  Created by 구태호 on 5/21/24.
//

import Foundation


extension String {
    var toURL: URL? { URL(string: self) }
}
