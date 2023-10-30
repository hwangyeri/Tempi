//
//  Color+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit

extension UIColor {

    enum AssetsColor {
        case deleteCancel // 삭제 모달 화면 - 삭제 알럿 취소 버튼 배경색
        case divider // 구분선 배경색
        case homeBackground // 홈화면 - 상단 백뷰 배경색
        case homeImage // 홈화면 - 컬렉션셀 이미지 배경색
        case listBackground // 체크리스트 추가 화면, 나의 리스트 화면 - 컬렉션뷰 배경색
        case point // 포인트 컬러
        case searchBackground // 홈 화면 - 서치 버튼 배경색
        case searchBorder // 홈 화면 - 서치 버튼 보더 컬러
        case searchPlaceholder // 홈 화면 - 서치 버튼 라벨 컬러
        case tButtonDisable // tButton - 비활성화 배경색
        case textFieldBackground // 편집 모달 화면 - 텍스트필드 배경색, 카테고리 상세 화면 - 컬렉션셀 비활성화 배경색
    }

    static func tColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .deleteCancel:
            return UIColor(named: "deleteCancel") // 999999 - 666666
        case .divider:
            return UIColor(named: "divider") // F3F3F3 - 434343
        case .homeBackground:
            return UIColor(named: "homeBackground") // 000000 - 161616
        case .homeImage:
            return UIColor(named: "homeImage") // 434343 - F3F3F3
        case .listBackground:
            return UIColor(named: "listBackground") // EEEFEF - 1C1C1E
        case .point:
            return UIColor(named: "point") // FF7B88 - FF7B88
        case .searchBackground:
            return UIColor(named: "searchBackground") // 434343 - 434343
        case .searchBorder:
            return UIColor(named: "searchBorder") // 666666 - 666666
        case .searchPlaceholder:
            return UIColor(named: "searchPlaceholder") // 999999 - 999999
        case .tButtonDisable:
            return UIColor(named: "tButtonDisable") // D9D9D9 - B7B7B7
        case .textFieldBackground:
            return UIColor(named: "textFieldBackground") // F3F3F3 - 434343
        }
    }

}
