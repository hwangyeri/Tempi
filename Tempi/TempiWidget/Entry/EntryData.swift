//
//  EntryData.swift
//  Tempi
//
//  Created by Yeri Hwang on 2024/03/20.
//

import WidgetKit

// 위젯을 구성하기 위해 필요한 Data
struct ChecklistEntry: TimelineEntry {
    var date: Date
    var checklistName: [String]
    var createdAt: [Date]
}
