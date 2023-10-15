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
}

class ChecklistTableRepository: ChecklistTableRepositoryType {
    
    private let realm = try! Realm()
    
    // Realm Create
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
    
    // Realm Read
    func fetch(completion: @escaping (Results<ChecklistTable>?) -> Void) {
        // 생성순으로 내림차순 정렬 (최근 날짜 -> 과거 날짜)
        let data = realm.objects(ChecklistTable.self).sorted(byKeyPath: "createdAt", ascending: false)
        completion(data)
    }
    
    func getObjectIdForItem(_ item: ChecklistTable) -> ObjectId? {
        // 새롭게 추가된 체크리스트의 ObjectId 를 추출하는 함수
        return item.id
    }
    
    func getChecklistName(forId id: ObjectId) -> String? {
        // ObjectId 으로 해당하는 checklistName 을 추출하는 함수
        if let item = realm.object(ofType: ChecklistTable.self, forPrimaryKey: id) {
            return item.checklistName
        }
        return nil
    }
    
    // Realm Update
//    func updateItem(id: ObjectId, title: String, contents: String) {
//        
//        do {
//            try realm.write {
//                //특정 테이블 값 변경 - 특정이 아닌 전체 수정
//                realm.create(ChecklistTable.self, value: ["id": id], update: .modified)
//                print("Realm Update Succeed")
//            }
//        } catch {
//            print(error)
//        }
//        
//    }
    
    // Realm Delete
//    func deleteItem(_ item: ChecklistTable) {
//        
//        do {
//            try realm.write {
//                realm.delete(item)
//                print("Realm Delete Succeed")
//            }
//        } catch {
//            print(error)
//        }
//        
//    }
    
}
