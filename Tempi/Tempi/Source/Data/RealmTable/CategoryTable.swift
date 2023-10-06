//
//  CategoryTable.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/06.
//

import Foundation
import RealmSwift

class CategoryTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var categoryName: String
    @Persisted var subCategoryName: String
    @Persisted var checkItem: String
    
    convenience init(categoryName: String, subCategoryName: String, checkItem: String) {
        self.init()
        
        self.categoryName = categoryName
        self.subCategoryName = subCategoryName
        self.checkItem = checkItem
    }
    
}
