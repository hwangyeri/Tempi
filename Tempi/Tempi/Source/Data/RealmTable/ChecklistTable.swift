//
//  ChecklistTable.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/06.
//

import Foundation
import RealmSwift

class ChecklistTable: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var checklistName: String // 체크리스트 이름
    @Persisted var createdAt: Date // 생성 날짜
    @Persisted var isFixed: Bool // 체크리스트 고정 여부
    
    convenience init(checklistName: String, createdAt: Date, isFixed: Bool) {
        self.init()
        
        self.checklistName = checklistName
        self.createdAt = createdAt
        self.isFixed = isFixed
    }
    
}
