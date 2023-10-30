//
//  NSNotification+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import Foundation

extension NSNotification.Name {
    /// 체크리스트 삭제
    static let deleteChecklist = NSNotification.Name("DeleteChecklist")
    
    /// 체크 아이템 삭제
    static let deleteCheckItem = NSNotification.Name("DeleteCheckItem")
    
    /// 체크리스트 이름 업데이트
    static let updateChecklistName = NSNotification.Name("UpdateChecklistName")
    
    /// 체크 아이템 내용 업데이트
    static let updateCheckItemContent = NSNotification.Name("UpdateCheckItemContent") 
    
    /// 체크 아이템 메모 업데이트
    static let updateCheckItemMemo = NSNotification.Name("UpdateCheckItemMemo")
    
    /// 홈화면에서 체크리스트 생성
    static let createChecklistFromHome = NSNotification.Name("CreateChecklistFromHome")
    
    /// 나의 체크리스트 화면에서 체크리스트 생성
    static let createChecklistFromMy = NSNotification.Name("CreateChecklistFromMy")
    
    /// 체크 아이템 생성
    static let createCheckItem = NSNotification.Name("CreateCheckItem")
    
    /// 즐겨찾기 항목 생성
    static let createBookmarkItem = NSNotification.Name("CreateBookmarkItem")
    
    /// 즐겨찾기 항목 삭제
    static let deleteBookmarkItem = NSNotification.Name("DeleteBookmarkItem")
    
    /// 체크리스트 삭제 시 알럿
    static let deleteChecklistAlert = NSNotification.Name("DeleteChecklistAlert")
}

