//
//  MyFirstWidgetWidgetLiveActivity.swift
//  MyFirstWidgetWidget
//
//  Created by 구태호 on 1/28/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MyFirstWidgetWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MyFirstWidgetWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MyFirstWidgetWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MyFirstWidgetWidgetAttributes {
    fileprivate static var preview: MyFirstWidgetWidgetAttributes {
        MyFirstWidgetWidgetAttributes(name: "World")
    }
}

extension MyFirstWidgetWidgetAttributes.ContentState {
    fileprivate static var smiley: MyFirstWidgetWidgetAttributes.ContentState {
        MyFirstWidgetWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MyFirstWidgetWidgetAttributes.ContentState {
         MyFirstWidgetWidgetAttributes.ContentState(emoji: "🤩")
     }
}


@available(iOS 17.0, *)
#Preview("Notification", as: .content, using: MyFirstWidgetWidgetAttributes.preview) {
   MyFirstWidgetWidgetLiveActivity()
} contentStates: {
    MyFirstWidgetWidgetAttributes.ContentState.smiley
    MyFirstWidgetWidgetAttributes.ContentState.starEyes
}
