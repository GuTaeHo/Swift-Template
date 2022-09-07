//
//  MainView.swift
//  CafeBee
//
//  Created by 구태호 on 2022/06/24.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        Text("MainView")
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .environment(\.colorScheme, .light)
            MainView()
                .environment(\.colorScheme, .dark)
        }
    }
}
