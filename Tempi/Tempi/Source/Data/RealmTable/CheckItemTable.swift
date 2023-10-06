//
//  CheckItemTable.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/06.
//

import Foundation
import RealmSwift

class CheckItemTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var checklistPK: String // 속한 체크 리스트 PK
    @Persisted var content: String // 내용
    @Persisted var memo: String?
    @Persisted var alarmDate: Date? // 알람 설정 날짜, 시간
    @Persisted var isChecked: Bool // 체크 여부
    
    convenience init(checklistPK: String, content: String, memo: String?, alarmDate: Date?, isChecked: Bool) {
        self.init()
        
        self.checklistPK = checklistPK
        self.content = content
        self.memo = memo
        self.alarmDate = alarmDate
        self.isChecked = isChecked
    }
    
}
