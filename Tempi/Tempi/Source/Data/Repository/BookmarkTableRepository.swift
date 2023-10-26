//
//  BookmarkTableRepository.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/25.
//

import Foundation
import RealmSwift

protocol BookmarkTableRepositoryType: AnyObject {
    func createItem(_ item: BookmarkTable)
    func fetch(completion: @escaping (Results<BookmarkTable>?) -> Void)
    func getCountForAllItems() -> Int
    func deleteItem(forId id: ObjectId)
}

class BookmarkTableRepository: BookmarkTableRepositoryType {
    
    private let realm = try! Realm()
    
    // MARK: - Realm Create
    func createItem(_ item: BookmarkTable) {
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
    func fetch(completion: @escaping (Results<BookmarkTable>?) -> Void) {
        /// 생성순으로 오름차순 정렬 (과거 날짜 -> 최근 날짜)
        let data = realm.objects(BookmarkTable.self).sorted(byKeyPath: "createdAt", ascending: true)
        completion(data)
    }
    
    func getCountForAllItems() -> Int {
        /// 전체 Bookmark Item 개수 반환
        let allItems = realm.objects(BookmarkTable.self)
        return allItems.count
    }
    
    // MARK: - Realm Delete
    func deleteItem(forId id: ObjectId) {
        /// ObjectId 를 기준으로 해당하는 Bookmark Item 삭제
        if let item = realm.object(ofType: BookmarkTable.self, forPrimaryKey: id) {
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
    
}
