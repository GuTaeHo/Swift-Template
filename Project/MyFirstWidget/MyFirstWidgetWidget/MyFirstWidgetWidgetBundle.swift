//
//  MyFirstWidgetWidgetBundle.swift
//  MyFirstWidgetWidget
//
//  Created by 구태호 on 1/28/25.
//

import WidgetKit
import SwiftUI

@main
@available(iOS 17.0, *)
struct MyFirstWidgetWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyFirstWidgetWidget()
        if #available(iOS 18, *) {
            MyFirstWidgetWidgetControl()
        }
        MyFirstWidgetWidgetLiveActivity()
    }
}
