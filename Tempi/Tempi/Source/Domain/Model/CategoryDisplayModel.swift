//
//  CategoryType.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/02.
//

import UIKit

enum CategoryDisplayModel: String {
    case outside
    case travel
    case cleaning
    case move
    case health
    case shopping
    case etc
    
    static let categories: [CategoryDisplayModel] = [.travel, .shopping, .cleaning, .move, .outside, .health, .etc]
    
    var image: UIImage? {
        switch self {
        case .outside:
            return UIImage(systemName: Constant.SFSymbol.outsideCategoryIcon)
        case .travel:
            return UIImage(systemName: Constant.SFSymbol.travelCategoryIcon)
        case .cleaning:
            return UIImage(systemName: Constant.SFSymbol.cleaningCategoryIcon)
        case .move:
            return UIImage(systemName: Constant.SFSymbol.moveCategoryIcon)
        case .health:
            return UIImage(systemName: Constant.SFSymbol.healthCategoryIcon)
        case .shopping:
            return UIImage(systemName: Constant.SFSymbol.shoppingCategoryIcon)
        case .etc:
            return UIImage(systemName: Constant.SFSymbol.etcCategoryIcon)
        }
    }
    
    var text: String {
        switch self {
        case .travel, .cleaning, .outside, .move, .health, .shopping, .etc:
            return "category_\(self.rawValue)".localized
        }
    }
    
}
