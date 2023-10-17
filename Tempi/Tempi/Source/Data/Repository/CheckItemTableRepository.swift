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
    
    // MARK: - Realm Update
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
    
    // MARK: - Realm Delete
    func deleteItem(forChecklistPK checklistPK: ObjectId) {
        /// checklistPK 를 기준으로 필터링, 해당하는 Check Item 을 삭제하는 함수
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
    
}
