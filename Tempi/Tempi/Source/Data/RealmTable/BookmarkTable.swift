//
//  BookmarkTable.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/06.
//

import Foundation
import RealmSwift

class BookmarkTable: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var content: String // 내용
    @Persisted var createdAt: Date // 생성 날짜
    
    convenience init(content: String, createdAt: Date) {
        self.init()
        
        self.content = content
        self.createdAt = createdAt
    }
    
}
