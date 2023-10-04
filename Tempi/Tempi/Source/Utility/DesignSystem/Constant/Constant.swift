//
//  Constant.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import Foundation

enum Constant {
    
    enum TButton {
        static let cornerRadius: CGFloat = 27
    }
    
    enum TKeywordBorder {
        static let cornerRadius: CGFloat = 18
        static let borderWidth: CGFloat = 1
    }
    
    enum TSubCategory {
        static let cornerRadius: CGFloat = 10
    }
    
    enum SFSymbol {
        /// Display Icon
        static let searchBarIcon: String = "magnifyingglass"
        static let plusCircleIcon: String = "plus.circle.fill"
        static let plusSquareIcon: String = "plus.square.fill" // plus.app.fill
        static let checkBoxIcon: String = "checkmark.square.fill"
        static let emptyBoxIcon: String = "square"
        static let editIcon: String = "pencil.line"
        static let deleteIcon: String = "trash"
        static let fixedIcon: String = "pin.fill"
        static let unfixedIcon: String = "pin"
        static let categoryEditIcon: String = "list.bullet"
        static let bookmarkIcon: String = "note.text.badge.plus"
        static let checkboxMenuIcon: String = "ellipsis"
        static let alarmIcon: String = "alarm"
        static let alarmMessageIcon: String = "message"
        static let alarmCheckIcon: String = "message"
        static let infoIcon: String = "checkmark"
        
        /// Category Icon
        static let travelCategoryIcon: String = "airplane.departure"
        static let shoppingCategoryIcon: String = "cart.fill"
        static let wishListCategoryIcon: String = "sparkles"
        static let bucketListCategoryIcon: String = "list.bullet.clipboard.fill"
        static let cleaningCategoryIcon: String = "bubbles.and.sparkles"
        static let healthCategoryIcon: String = "figure.run"
        static let beforeGoingOutCategoryIcon: String = "car.fill"
        static let moveCategoryIcon: String = "box.truck.fill"
        
        /// CheckBox Drop-down Menu Icon
        static let editCheckBoxIcon: String = "pencil"
        static let memoCheckBoxIcon: String = "note.text"
        static let alarmCheckBoxIcon: String = "alarm"
        static let bookmarkCheckBoxIcon: String = "star"
        static let deletemarkCheckBoxIcon: String = "trash"
        
        /// TabBar Icon
        static let firstTabBarIcon: String = "doc.text.magnifyingglass"
        static let secondTabBarIcon: String = "house"
        static let thirdTabBarIcon: String = "calendar"
    }
    
}
