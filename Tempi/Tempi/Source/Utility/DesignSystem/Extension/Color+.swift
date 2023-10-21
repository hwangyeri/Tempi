//
//  Color+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit

extension UIColor {

    enum AssetsColor {
        case point
        case tGray100
        case tGray200
        case tGray300
        case tGray400
        case tGray500
        case tGray600
        case tGray700
        case tGray800
        case tGray900
        case tGray1000
    }

    static func tColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .point:
            return UIColor(named: "point")
        case .tGray100:
            return UIColor(named: "tGray100") // FFFFFF - 000000
        case .tGray200:
            return UIColor(named: "tGray200") // F3F3F3 - 434343
        case .tGray300:
            return UIColor(named: "tGray300") // EFEFEF - 666666
        case .tGray400:
            return UIColor(named: "tGray400") // D9D9D9 - 999999
        case .tGray500:
            return UIColor(named: "tGray500") // CCCCCC - B7B7B7
        case .tGray600:
            return UIColor(named: "tGray600") // B7B7B7 - CCCCCC
        case .tGray700:
            return UIColor(named: "tGray700") // 999999 - D9D9D9
        case .tGray800:
            return UIColor(named: "tGray800") // 666666 - EFEFEF
        case .tGray900:
            return UIColor(named: "tGray900") // 434343 - F3F3F3
        case .tGray1000:
            return UIColor(named: "tGray1000") // 000000 - FFFFFF
        }
    }

}
