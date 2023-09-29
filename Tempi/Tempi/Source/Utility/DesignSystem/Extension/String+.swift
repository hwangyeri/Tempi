//
//  String+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import Foundation

extension String {
    
    // MARK: - localized
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with:Int) ->  String {
        return StringLiteralType(format: self, with)
        
    }
    
    func localized(number:Int) ->  String {
        return StringLiteralType(format: self, number)
        
    }
    
}
