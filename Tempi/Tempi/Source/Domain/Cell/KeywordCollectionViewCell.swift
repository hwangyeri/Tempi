//
//  KeywordCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/02.
//

import UIKit
import SnapKit

class KeywordCollectionViewCell: BaseCollectionViewCell {
    
    // FIXME: Border 가 안보임... Color 변경해야 함
    
    let borderView = {
        let view = UIView()
        view.layer.cornerRadius = Constant.TKeywordLabel.cornerRadius
        view.layer.borderWidth = Constant.TKeywordLabel.borderWidth
        view.layer.borderColor = UIColor.red.cgColor
        view.backgroundColor = .yellow
        return view
    }()

    let keywordLabel = {
        let view = TLabel(
            text: "테스트",
            custFont: .pretendardSemiBoldXS,
            textColor: .tGray1000)
//        view.layer.cornerRadius = Constant.TKeywordLabel.cornerRadius
//        view.layer.borderColor = UIColor.yellow.cgColor
//        view.layer.borderWidth = Constant.TKeywordLabel.borderWidth
//        view.backgroundColor = UIColor.lightGray
        view.numberOfLines = 0
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(borderView)
        borderView.addSubview(keywordLabel)
    }
    
    override func configureLayout() {
        borderView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
//        keywordLabel.snp.makeConstraints { make in
//            make.edges.equalTo(borderView)
//        }
    }
    
}
