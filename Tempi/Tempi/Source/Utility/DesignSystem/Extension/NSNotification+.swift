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
    
    /// 체크리스트 생성
    static let createChecklistFromHome = NSNotification.Name("CreateChecklistFromHome") // 홈 화면
    static let createChecklistFromMy = NSNotification.Name("CreateChecklistFromMy") // 나의 리스트 화면
    
    /// 체크 아이템 생성
    static let createCheckItem = NSNotification.Name("CreateCheckItem")
    
    /// 즐겨찾기 항목 생성
    static let createBookmarkItem = NSNotification.Name("CreateBookmarkItem")
    
    /// 체크리스트 삭제 시 알럿
    static let deleteChecklistAlert = NSNotification.Name("DeleteChecklistAlert")
    
    /// 체크리스트 고정 버튼 UI 업데이트
    static let updateChecklistFixedButton = NSNotification.Name("UpdateChecklistFixedButton")
    
    /// 체크박스 체크 시 알럿
    static let updateCheckBoxStateAlert = NSNotification.Name("UpdateCheckBoxStateAlert")
}

