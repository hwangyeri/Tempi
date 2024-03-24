//
//  Ex+Font.swift
//  TempiWidgetExtension
//
//  Created by Yeri Hwang on 2024/03/24.
//

import SwiftUI

enum CustomFont {
    case pretendardSemiBold
}

extension Font {
    static func pretendard(_ style: CustomFont) -> Font {
        switch style {
        case .pretendardSemiBold:
            return Font.custom("Pretendard-SemiBold", size: 14)
        }
    }
}

