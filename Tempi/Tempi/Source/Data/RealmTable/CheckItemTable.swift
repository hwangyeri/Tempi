//
//  CheckItemTable.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/06.
//

import Foundation
import RealmSwift

class CheckItemTable: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var checklistPK: ObjectId // 속한 체크 리스트 PK
    @Persisted var content: String // 내용
    @Persisted var createdAt: Date // 생성 날짜
    @Persisted var memo: String? // 메모
    @Persisted var alarmDate: Date? // 알람 설정 날짜, 시간
    @Persisted var isChecked: Bool // 체크 여부
    
    convenience init(checklistPK: ObjectId, content: String, createdAt: Date, memo: String?, alarmDate: Date?, isChecked: Bool) {
        self.init()
        
        self.checklistPK = checklistPK
        self.content = content
        self.createdAt = createdAt
        self.memo = memo
        self.alarmDate = alarmDate
        self.isChecked = isChecked
    }
    
}
