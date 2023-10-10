//
//  CategoryDefaultModel.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/08.
//

import Foundation

// MARK: - Category
struct Category: Codable, Hashable {
    let categoryDefaultData: [CategoryDefaultData]
}

// MARK: - CategoryDefaultData
struct CategoryDefaultData: Codable, Hashable {
    let categoryName, subCategoryName, checkItem: String
}
