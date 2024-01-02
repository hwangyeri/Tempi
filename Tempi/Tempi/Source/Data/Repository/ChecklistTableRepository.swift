//
//  ChecklistTableRepository.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/15.
//

import Foundation
import RealmSwift

protocol ChecklistTableRepositoryType: AnyObject {
    func createItem(_ item: ChecklistTable)
    func fetch(completion: @escaping (Results<ChecklistTable>?) -> Void)
    func getObjectIdForItem(_ item: ChecklistTable) -> ObjectId?
    func getChecklistName(forId id: ObjectId) -> String?
    func getChecklistDate(forId id: ObjectId) -> Date?
}

class ChecklistTableRepository: ChecklistTableRepositoryType {
    
    private let realm = try! Realm()
    
    // MARK: - Realm Create
    func createItem(_ item: ChecklistTable) {
        do {
            try realm.write {
                realm.add(item)
                print("Realm Add Succeed")
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Realm Read
    func fetch(completion: @escaping (Results<ChecklistTable>?) -> Void) {
        /// 생성순으로 내림차순 정렬 (최근 날짜 -> 과거 날짜)
        let data = realm.objects(ChecklistTable.self).sorted(byKeyPath: "createdAt", ascending: false)
        completion(data)
    }
    
    func getObjectIdForItem(_ item: ChecklistTable) -> ObjectId? {
        /// 새롭게 추가된 Checklist_ObjectId 반환
        return item.id
    }
    
    func getChecklistName(forId id: ObjectId) -> String? {
        /// ObjectId 를 기준으로 Checklist_checklistName 반환
        if let item = realm.object(ofType: ChecklistTable.self, forPrimaryKey: id) {
            return item.checklistName
        }
        return nil
    }
    
    func getChecklistDate(forId id: ObjectId) -> Date? {
        /// ObjectId 를 기준으로 Checklist_createdAt 반환
        if let item = realm.object(ofType: ChecklistTable.self, forPrimaryKey: id) {
            return item.createdAt
        }
        return nil
    }
    
    func getIsFixed(forId id: ObjectId) -> Bool? {
        /// ObjectId 를 기준으로 Checklist_isFixed 반환
        if let item = realm.object(ofType: ChecklistTable.self, forPrimaryKey: id) {
            return item.isFixed
        }
        return nil
    }
    
    func getLatestChecklistId() -> ObjectId? {
        /// createdAt 을 기준으로 내림차순 정렬
        /// 가장 최근에 생성된 Checklist_id 반환
        let latestChecklist = realm.objects(ChecklistTable.self).sorted(byKeyPath: "createdAt", ascending: false).first
        return latestChecklist?.id
    }
    
    // MARK: - Realm Update
    func updateIsFixed(forId id: ObjectId, newIsFixed: Bool) {
        /// ObjectId 를 기준으로 Checklist_isFixed 업데이트
        if let item = realm.object(ofType: ChecklistTable.self, forPrimaryKey: id) {
            do {
                try realm.write {
                    item.isFixed = newIsFixed
                    print("Realm Update isFixed Succeed")
                }
            } catch {
                print(error)
            }
        }
    }
    
    func updateChecklistName(forId id: ObjectId, newChecklistName: String) {
        /// ObjectId 를 기준으로 Checklist_checklistName 업데이트
        if let item = realm.object(ofType: ChecklistTable.self, forPrimaryKey: id) {
            do {
                try realm.write {
                    item.checklistName = newChecklistName
                    print("Realm Update checklistName Succeed")
                }
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Realm Delete
    func deleteItem(forId id: ObjectId) {
        /// ObjectId 를 기준으로 해당하는 Checklist 삭제
        if let item = realm.object(ofType: ChecklistTable.self, forPrimaryKey: id) {
            do {
                try realm.write {
                    realm.delete(item)
                    print("Realm Delete Succeed")
                }
            } catch {
                print(error)
            }
        }
    }
    
    // 전체 Realm 데이터 삭제 메서드
    func deleteAllData() {
        do {
            try realm.write {
                realm.deleteAll()
                print("전체 데이터 삭제 성공!")
            }
        } catch {
            print("Error deleting All Data: \(error)")
        }
    }
    
}
