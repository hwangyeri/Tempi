//
//  BookmarkTable.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/06.
//

import Foundation
import RealmSwift

class BookmarkTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var bookmarkItem: String // 즐겨찾기 항목
    
    convenience init(bookmarkItem: String) {
        self.init()
        
        self.bookmarkItem = bookmarkItem
    }
    
}
