//
//  ChecklistTable.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/06.
//

import Foundation
import RealmSwift

class ChecklistTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var checklistName: String
    @Persisted var createdAt: Data // 생성 날짜
    
    convenience init(checklistName: String, createdAt: Data) {
        self.init()
        
        self.checklistName = checklistName
        self.createdAt = createdAt
    }
    
}
