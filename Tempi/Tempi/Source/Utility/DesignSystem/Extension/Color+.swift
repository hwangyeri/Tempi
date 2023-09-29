//
//  Color+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit

extension UIColor {
    
    // FIXME: tempColor 적용중... Color 확정 후, Assets Color 변경하기

    enum AssetsColor {
        case point
        case tpGray100
        case tpGray200
        case tpGray300
        case tpGray400
        case tpGray500
        case tpGray600
        case tpGray700
        case tpGray800
        case tpGray900
        case tpGray1000
    }

    static func tpColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .point:
            return UIColor(named: "point")
        case .tpGray100:
            return UIColor(named: "tpGray100")
        case .tpGray200:
            return UIColor(named: "tpGray200")
        case .tpGray300:
            return UIColor(named: "tpGray300")
        case .tpGray400:
            return UIColor(named: "tpGray400")
        case .tpGray500:
            return UIColor(named: "tpGray500")
        case .tpGray600:
            return UIColor(named: "tpGray600")
        case .tpGray700:
            return UIColor(named: "tpGray700")
        case .tpGray800:
            return UIColor(named: "tpGray800")
        case .tpGray900:
            return UIColor(named: "tpGray900")
        case .tpGray1000:
            return UIColor(named: "tpGray1000")
        }
    }

}
