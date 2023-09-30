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
            return UIColor(named: "tGray100")
        case .tGray200:
            return UIColor(named: "tGray200")
        case .tGray300:
            return UIColor(named: "tGray300")
        case .tGray400:
            return UIColor(named: "tGray400")
        case .tGray500:
            return UIColor(named: "tGray500")
        case .tGray600:
            return UIColor(named: "tGray600")
        case .tGray700:
            return UIColor(named: "tGray700")
        case .tGray800:
            return UIColor(named: "tGray800")
        case .tGray900:
            return UIColor(named: "tGray900")
        case .tGray1000:
            return UIColor(named: "tGray1000")
        }
    }
    
    enum SystemColor {
        case background
        case label
    }
    
    static func sColor(_ name: SystemColor) -> UIColor? {
        switch name {
        case .background:
            return UIColor.systemBackground
        case .label:
            return UIColor.label
        }
    }

}
