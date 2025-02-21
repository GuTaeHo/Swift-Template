//
//  AppIntent.swift
//  MyFirstWidgetWidget
//
//  Created by 구태호 on 1/28/25.
//

import WidgetKit
import AppIntents

/// 위젯 동작 정의, App Intent 를 정의하고 위젯이나 단축어에서 Intent 를 호출하여 동작 실행
@available(iOS 17.0, *)
struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}


@available(iOS 17.0, *)
extension ConfigurationAppIntent {
    static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}
