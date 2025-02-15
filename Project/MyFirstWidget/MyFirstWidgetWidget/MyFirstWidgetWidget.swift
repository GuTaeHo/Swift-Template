//
//  MyFirstWidgetWidget.swift
//  MyFirstWidgetWidget
//
//  Created by 구태호 on 1/28/25.
//

import WidgetKit
import SwiftUI

/**
 TimelineProvider 정의
 TimelineProvider는 위젯에 표시할 데이터를 제공하며, 다음 세 가지 메서드를 구현합니다:

 placeholder(in:): 위젯이 로드 중일 때 표시할 기본 UI를 제공합니다.
 snapshot(for:in:): 위젯의 미리보기를 제공합니다.
 timeline(for:in:): 시간에 따라 업데이트되는 데이터를 제공합니다.
 */
@available(iOS 17.0, *)
struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

@available(iOS 17.0, *)
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

/**
 위젯 UI
 */
@available(iOS 17.0, *)
struct MyFirstWidgetWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Favorite Emoji:")
            Text(entry.configuration.favoriteEmoji)
        }
    }
}

/*
 위젯의 이름, 크기, 프로바이더 설정
 */
@available(iOS 17.0, *)
struct MyFirstWidgetWidget: Widget {
    let kind: String = "위젯이름"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            MyFirstWidgetWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

@available(iOS 17.0, *)
#Preview(as: .systemSmall) {
    MyFirstWidgetWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
