//
//  UserDefaults+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/11/15.
//

import Foundation

extension UserDefaults {
    
    // 새로운 체크리스트를 생성하는 경우를 구분해서 Bool 값으로 저장, true == showMessage 띄워주기
    var isCreated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isCreated")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isCreated")
        }
    }
}
