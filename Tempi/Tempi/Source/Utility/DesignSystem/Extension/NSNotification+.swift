//
//  NSNotification+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import Foundation

extension NSNotification.Name {
    static let deleteChecklist = NSNotification.Name("DeleteChecklist")
    static let deleteCheckItem = NSNotification.Name("DeleteCheckItem")
    static let updateChecklistName = NSNotification.Name("UpdateChecklistName")
    static let updateCheckItemContent = NSNotification.Name("UpdateCheckItemContent")
    static let updateCheckItemMemo = NSNotification.Name("UpdateCheckItemMemo")
    static let createChecklist = NSNotification.Name("CreateChecklist")
}
