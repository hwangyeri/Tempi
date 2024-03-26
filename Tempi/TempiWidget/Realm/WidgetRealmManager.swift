//
//  WidgetRealmManager.swift
//  Tempi
//
//  Created by Yeri Hwang on 2024/03/20.
//

import Foundation
import RealmSwift

final class WidgetRealmManager {
    
    static let shared = WidgetRealmManager()
    
    private init() { }
    
    private var realm: Realm {
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.yerihwang.Tempi")
        let realmURL = container?.appendingPathComponent("default.realm")
        let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 1)
        return try! Realm(configuration: config)
    }

    // Realm DB에서 체크리스트 데이터를 로드하는 함수
    func fetchChecklistData() -> ChecklistEntry {
        let checklistItems = realm.objects(ChecklistTable.self).sorted(byKeyPath: "createdAt", ascending: true)
        
        let checklistNames = Array(checklistItems.map { $0.checklistName })
        let createdAtDates = Array(checklistItems.map { $0.createdAt })
        
        return ChecklistEntry(date: Date(), checklistName: checklistNames, createdAt: createdAtDates)
    }
    
}
