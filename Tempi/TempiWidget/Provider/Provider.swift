//
//  Provider.swift
//  TempiWidgetExtension
//
//  Created by Yeri Hwang on 2024/03/20.
//

import WidgetKit

struct Provider: TimelineProvider {
    
    typealias Entry = ChecklistEntry
    
    // 위젯킷이 최초로 랜더링할 때 사용 > 스켈레톤 뷰 랜더링
    func placeholder(in context: Context) -> ChecklistEntry {
        ChecklistEntry(date: Date(), checklistName: ["Checklist"], createdAt: [Date()])
    }

    // 위젯 갤러리 미리보기 화면 설정
    func getSnapshot(in context: Context, completion: @escaping (ChecklistEntry) -> ()) {
        let entry = ChecklistEntry(date: Date(), checklistName: ["Checklist"], createdAt: [Date()])
        completion(entry)
    }
    
    // 위젯 상태 변경 시점 설정
    func getTimeline(in context: Context, completion: @escaping (Timeline<ChecklistEntry>) -> ()) {
        let checklistEntry = WidgetRealmManager.shared.fetchChecklistData()
        let nextUpdateDate = Date()
        let timeline = Timeline(entries: [checklistEntry], policy: .after(nextUpdateDate))
        completion(timeline)
    }
    
}
