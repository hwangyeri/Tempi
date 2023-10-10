//
//  CategoryType.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/02.
//

import UIKit

enum CategoryDisplayModel: String {
    case travel
    case shopping
    case wishList
    case bucketList
    case cleaning
    case move
    case beforeGoingOut
    case health
    
    static let categories: [CategoryDisplayModel] = [.travel, .shopping, .wishList, .beforeGoingOut, .bucketList, .health, .cleaning, .move]
    
    var image: UIImage? {
        switch self {
        case .travel:
            return UIImage(systemName: Constant.SFSymbol.travelCategoryIcon)
        case .shopping:
            return UIImage(systemName: Constant.SFSymbol.shoppingCategoryIcon)
        case .wishList:
            return UIImage(systemName: Constant.SFSymbol.wishListCategoryIcon)
        case .bucketList:
            return UIImage(systemName: Constant.SFSymbol.bucketListCategoryIcon)
        case .cleaning:
            return UIImage(systemName: Constant.SFSymbol.cleaningCategoryIcon)
        case .move:
            return UIImage(systemName: Constant.SFSymbol.moveCategoryIcon)
        case .beforeGoingOut:
            return UIImage(systemName: Constant.SFSymbol.beforeGoingOutCategoryIcon)
        case .health:
            return UIImage(systemName: Constant.SFSymbol.healthCategoryIcon)
        }
    }
    
    var text: String {
        switch self {
        case .travel, .shopping, .wishList, .bucketList, .cleaning, .beforeGoingOut, .health, .move:
            return "category_\(self.rawValue)".localized
        }
    }
    
}
