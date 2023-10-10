//
//  TempiModel.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/07.
//

import Foundation

struct Checklist: Codable, Hashable {
    let checklistName: String
    let createdAt: Date
}

struct CheckItem: Codable, Hashable {
    let content: String
    let memo: String?
    let alarmDate: Date?
    let isChecked: Bool
}

struct Bookmark: Codable, Hashable {
    let bookmarkItem: String
}
