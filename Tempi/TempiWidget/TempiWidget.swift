//
//  TempiWidget.swift
//  TempiWidget
//
//  Created by Yeri Hwang on 2024/03/20.
//

import WidgetKit
import SwiftUI

struct TempiWidget: Widget {
    // kind: 위젯을 식별하기 위한 아이디
    // provider: 위젯을 새로고침할 타임라인을 결정하는 객체
    
    let kind: String = "TempiWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                TempiWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TempiWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .contentMarginsDisabled()
        .configurationDisplayName("나의 체크리스트")
        .description("위젯을 통해 체크리스트를 확인해 보세요.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

//#Preview(as: .systemSmall) {
//    TempiWidget()
//} timeline: {
//    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
//}
