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
        let timeline = Timeline(entries: [checklistEntry], policy: .atEnd)
        completion(timeline)
    }

}

//struct Provider: TimelineProvider {
//    
//    typealias Entry = ChecklistEntry
//    
//    // 위젯킷이 최초로 랜더링할 때 사용 > 스켈레톤 뷰 랜더링
//    func placeholder(in context: Context) -> ChecklistEntry {
//        ChecklistEntry(checklistName: "Checklist", date: Date())
//    }
//
//    // 위젯 갤러리 미리보기 화면 설정
//    func getSnapshot(in context: Context, completion: @escaping (ChecklistEntry) -> ()) {
//        let entry = ChecklistEntry(checklistName: "미리보기", date: Date())
//        completion(entry)
//    }
//    
//    // 위젯 상태 변경 시점 설정
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        let checklistData = WidgetRealmManager.shared.fetchChecklistData()
//        var entries: [ChecklistEntry] = []
//
//        for checklist in checklistData {
//            // 각 체크리스트 항목을 바탕으로 엔트리 생성
//            let entry = ChecklistEntry(checklistName: checklist.checklistName, date: checklist.date)
//            entries.append(entry)
//        }
//
//        // 데이터가 없는 경우, 기본 엔트리 추가
//        if entries.isEmpty {
//            entries.append(ChecklistEntry(checklistName: "데이터 없음", date: Date()))
//        }
//        
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//
//}

