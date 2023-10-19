//
//  CheckItemTableRepository.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/15.
//

import Foundation
import RealmSwift

protocol CheckItemTableRepositoryType: AnyObject {
    func createItem(_ item: CheckItemTable)
    func fetch(for checklistID: ObjectId, completion: @escaping (Results<CheckItemTable>?) -> Void)
}

class CheckItemTableRepository: CheckItemTableRepositoryType {
    
    private let realm = try! Realm()
    
    // MARK: - Realm Create
    func createItem(_ item: CheckItemTable) {
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
    func fetch(for checklistID: ObjectId, completion: @escaping (Results<CheckItemTable>?) -> Void) {
        /// checklistID 를 기준으로 필터링
        /// 생성순으로 오름차순 정렬 (과거 날짜 -> 최근 날짜)
        let filteredData = realm.objects(CheckItemTable.self).filter("checklistPK == %@", checklistID).sorted(byKeyPath: "createdAt", ascending: true)
        completion(filteredData)
    }
    
    func getCheckItemIsChecked(forId id: ObjectId) -> Bool? {
        /// ObjectId 를 기준으로 Check Item_isChecked 반환
        if let item = realm.object(ofType: CheckItemTable.self, forPrimaryKey: id) {
            return item.isChecked
        } else {
            return nil
        }
    }
    
    func getCheckItemContent(forId id: ObjectId) -> String? {
        /// ObjectId 를 기준으로 Check Item_content 반환
        if let item = realm.object(ofType: CheckItemTable.self, forPrimaryKey: id) {
            return item.content
        } else {
            return nil
        }
    }
    
    func getCheckItemMemo(forId id: ObjectId) -> String? {
        /// ObjectId 를 기준으로 Check Item_memo 반환
        if let item = realm.object(ofType: CheckItemTable.self, forPrimaryKey: id) {
            return item.memo
        } else {
            return nil
        }
    }
    
    // MARK: - Realm Update
    func updateCheckItemContent(forId id: ObjectId, newContent: String) {
        /// ObjectId 를 기준으로 Check Item_content 업데이트
        if let item = realm.object(ofType: CheckItemTable.self, forPrimaryKey: id) {
            try? realm.write {
                item.content = newContent
            }
        }
    }

    func updateCheckItemMemo(forId id: ObjectId, newMemo: String) {
        /// ObjectId 를 기준으로 Check Item_memo 업데이트
        if let item = realm.object(ofType: CheckItemTable.self, forPrimaryKey: id) {
            try? realm.write {
                item.memo = newMemo
            }
        }
    }
    
    func updateCheckItemIsChecked(forId id: ObjectId, newIsChecked: Bool) {
        /// ObjectId 를 기준으로 Check Item_isChecked 업데이트
        if let item = realm.object(ofType: CheckItemTable.self, forPrimaryKey: id) {
            do {
                try realm.write {
                    item.isChecked = newIsChecked
                }
            } catch {
                print("Error updating isChecked for check item: \(error)")
            }
        }
    }
    
    // MARK: - Realm Delete
    func deleteAllCheckItem(forChecklistPK checklistPK: ObjectId) {
        /// checklistPK 를 기준으로 필터링, 해당하는 모든 Check Item 삭제
        let itemsToDelete = realm.objects(CheckItemTable.self).filter("checklistPK == %@", checklistPK)
        do {
            try realm.write {
                realm.delete(itemsToDelete)
                print("Realm Delete Succeed")
            }
        } catch {
            print(error)
        }
    }
    
    func deleteCheckItem(withID id: ObjectId) {
        /// ObjectId 를 기준으로 해당하는 Check Item 삭제
        do {
            let realm = try Realm()
            if let itemToDelete = realm.object(ofType: CheckItemTable.self, forPrimaryKey: id) {
                try realm.write {
                    realm.delete(itemToDelete)
                }
                print("Realm Delete Succeed")
            } else {
                print("Error: Item with ID \(id) not found.")
            }
        } catch {
            print("Error deleting check item: \(error)")
        }
    }
    
}
