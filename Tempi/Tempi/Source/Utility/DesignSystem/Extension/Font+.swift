//
//  Font+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit

/*
 Pretendard
 == Pretendard-Regular
 == Pretendard-Medium
 == Pretendard-SemiBold
 == Pretendard-Bold
 == Pretendard-Black
 
 Font Size
 == XXS: 12
 == XS: 13
 == S: 14
 == M: 15
 == L: 16
 == XL: 20
 == XXL: 24
 */

extension UIFont {
    
    enum CustomFont {
        
        /// Regular
        case pretendardRegularXXS
        case pretendardRegularXS
        case pretendardRegularS
        case pretendardRegularM
        case pretendardRegularL
        case pretendardRegularXL
        case pretendardRegularXXL
        
        /// Medium
        case pretendardMediumXXS
        case pretendardMediumXS
        case pretendardMediumS
        case pretendardMediumM
        case pretendardMediumL
        case pretendardMediumXL
        case pretendardMediumXXL
        
        /// SemiBold
        case pretendardSemiBoldXXS
        case pretendardSemiBoldXS
        case pretendardSemiBoldS
        case pretendardSemiBoldM
        case pretendardSemiBoldL
        case pretendardSemiBoldXL
        case pretendardSemiBoldXXL
        
        /// Bold
        case pretendardBoldXXS
        case pretendardBoldXS
        case pretendardBoldS
        case pretendardBoldM
        case pretendardBoldL
        case pretendardBoldXL
        case pretendardBoldXXL
        
        /// Black
        case pretendardBlackXXS
        case pretendardBlackXS
        case pretendardBlackS
        case pretendardBlackM
        case pretendardBlackL
        case pretendardBlackXL
        case pretendardBlackXXL
    }
    
    static func customFont(_ name: CustomFont) -> UIFont? {
        switch name {
        case .pretendardRegularXXS:
            return UIFont(name: "Pretendard-Regular", size: 12)
        case .pretendardRegularXS:
            return UIFont(name: "Pretendard-Regular", size: 13)
        case .pretendardRegularS:
            return UIFont(name: "Pretendard-Regular", size: 14)
        case .pretendardRegularM:
            return UIFont(name: "Pretendard-Regular", size: 15)
        case .pretendardRegularL:
            return UIFont(name: "Pretendard-Regular", size: 16)
        case .pretendardRegularXL:
            return UIFont(name: "Pretendard-Regular", size: 20)
        case .pretendardRegularXXL:
            return UIFont(name: "Pretendard-Regular", size: 24)
            
        case .pretendardMediumXXS:
            return UIFont(name: "Pretendard-Medium", size: 12)
        case .pretendardMediumXS:
            return UIFont(name: "Pretendard-Medium", size: 13)
        case .pretendardMediumS:
            return UIFont(name: "Pretendard-Medium", size: 14)
        case .pretendardMediumM:
            return UIFont(name: "Pretendard-Medium", size: 15)
        case .pretendardMediumL:
            return UIFont(name: "Pretendard-Medium", size: 16)
        case .pretendardMediumXL:
            return UIFont(name: "Pretendard-Medium", size: 20)
        case .pretendardMediumXXL:
            return UIFont(name: "Pretendard-Medium", size: 24)
            
        case .pretendardSemiBoldXXS:
            return UIFont(name: "Pretendard-SemiBold", size: 12)
        case .pretendardSemiBoldXS:
            return UIFont(name: "Pretendard-SemiBold", size: 13)
        case .pretendardSemiBoldS:
            return UIFont(name: "Pretendard-SemiBold", size: 14)
        case .pretendardSemiBoldM:
            return UIFont(name: "Pretendard-SemiBold", size: 15)
        case .pretendardSemiBoldL:
            return UIFont(name: "Pretendard-SemiBold", size: 16)
        case .pretendardSemiBoldXL:
            return UIFont(name: "Pretendard-SemiBold", size: 20)
        case .pretendardSemiBoldXXL:
            return UIFont(name: "Pretendard-SemiBold", size: 24)
            
        case .pretendardBoldXXS:
            return UIFont(name: "Pretendard-Bold", size: 12)
        case .pretendardBoldXS:
            return UIFont(name: "Pretendard-Bold", size: 13)
        case .pretendardBoldS:
            return UIFont(name: "Pretendard-Bold", size: 14)
        case .pretendardBoldM:
            return UIFont(name: "Pretendard-Bold", size: 15)
        case .pretendardBoldL:
            return UIFont(name: "Pretendard-Bold", size: 16)
        case .pretendardBoldXL:
            return UIFont(name: "Pretendard-Bold", size: 20)
        case .pretendardBoldXXL:
            return UIFont(name: "Pretendard-Bold", size: 24)
            
        case .pretendardBlackXXS:
            return UIFont(name: "Pretendard-Black", size: 12)
        case .pretendardBlackXS:
            return UIFont(name: "Pretendard-Black", size: 13)
        case .pretendardBlackS:
            return UIFont(name: "Pretendard-Black", size: 14)
        case .pretendardBlackM:
            return UIFont(name: "Pretendard-Black", size: 15)
        case .pretendardBlackL:
            return UIFont(name: "Pretendard-Black", size: 16)
        case .pretendardBlackXL:
            return UIFont(name: "Pretendard-Black", size: 20)
        case .pretendardBlackXXL:
            return UIFont(name: "Pretendard-Black", size: 24)
        }
    }
    
}

