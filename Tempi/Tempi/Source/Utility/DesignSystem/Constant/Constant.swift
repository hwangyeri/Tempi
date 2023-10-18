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
        static let borderWidth: CGFloat = 1
    }
    
    enum TKeywordBorder {
        static let cornerRadius: CGFloat = 17
        static let borderWidth: CGFloat = 1
    }
    
    enum TSubCategory {
        static let cornerRadius: CGFloat = 10
    }
    
    enum TBlankCheckBox {
        static let cornerRadius: CGFloat = 6
        static let borderWidth: CGFloat = 1
    }
    
    enum TBookmarkListButton {
        static let cornerRadius: CGFloat = 20
        static let borderWidth: CGFloat = 1.5
        static let imagePadding: CGFloat = 8
    }
    
    enum TChecklist {
        static let cornerRadius: CGFloat = 30
        static let borderWidth: CGFloat = 1
        static let selectedBorderWidth: CGFloat = 2
        static let imagePadding: CGFloat = 10
        static let symbolPointSize: CGFloat = 15
    }
    
    enum TImageButton {
        static let checklistImageSize: CGFloat = 23
        static let bookmarkListImageSize: CGFloat = 20
        static let checklistCollectionCellImageSize: CGFloat = 25
        static let editChecklistNameImageSize: CGFloat = 23
    }
    
    enum TPopUp {
        static let viewCornerRadius: CGFloat = 23
        static let buttonCornerRadius: CGFloat = 23
    }
    
    enum SFSymbol {
        /// Display Icon
        static let searchBarIcon: String = "magnifyingglass"
        static let plusCircleIcon: String = "plus.circle.fill"
        static let plusSquareIcon: String = "plus.square.fill" // plus.app.fill
        static let plusIcon: String = "plus"
        static let checkIcon: String = "checkmark"
        static let xmarkIcon: String = "xmark"
//        static let emptyBoxIcon: String = "square"
        static let checklistNameEditIcon: String = "pencil.line"
        static let checklistDeleteIcon: String = "trash"
        static let checklistFixedIcon: String = "pin.fill"
        static let checklistUnFixedIcon: String = "pin"
//        static let categoryEditIcon: String = "list.bullet"
        static let bookmarkListIcon: String = "contextualmenu.and.cursorarrow" //"note.text.badge.plus"
        static let checkboxMenuIcon: String = "ellipsis"
//        static let alarmIcon: String = "alarm"
//        static let alarmMessageIcon: String = "message"
//        static let alarmCheckIcon: String = "checkmark"
        static let infoIcon: String = "info.circle"
        
        /// Category Icon
        static let travelCategoryIcon: String = "airplane.departure"
        static let shoppingCategoryIcon: String = "cart.fill"
        static let wishListCategoryIcon: String = "sparkles"
        static let bucketListCategoryIcon: String = "list.bullet.clipboard.fill"
        static let cleaningCategoryIcon: String = "bubbles.and.sparkles"
        static let healthCategoryIcon: String = "figure.run"
        static let beforeGoingOutCategoryIcon: String = "car.fill"
        static let moveCategoryIcon: String = "box.truck.fill"
        
        /// Checklist Menu Icon
        static let editMenuItemIcon: String = "pencil"
        static let addMemoMenuItemIcon: String = "note.text"
//        static let alarmCheckBoxIcon: String = "alarm"
//        static let bookmarkCheckBoxIcon: String = "star"
        static let deleteMemuItemIcon: String = "trash"
        
        /// TabBar Icon
        static let firstTabBarIcon: String = "doc.text.magnifyingglass"
        static let secondTabBarIcon: String = "house"
        static let thirdTabBarIcon: String = "calendar"
    }
    
}
