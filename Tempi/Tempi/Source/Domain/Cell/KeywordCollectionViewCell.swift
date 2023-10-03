//
//  KeywordCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/02.
//

import UIKit
import SnapKit

class KeywordCollectionViewCell: BaseCollectionViewCell {
    
    let borderView = {
        let view = UIView()
        view.layer.borderWidth = Constant.TKeywordBorder.borderWidth
        view.layer.borderColor = UIColor.tGray400.cgColor
        view.layer.cornerRadius = Constant.TKeywordBorder.cornerRadius
        view.backgroundColor = UIColor.tGray100
        return view
    }()

    let keywordLabel = {
        let view = TLabel(
            text: "테스트",
            custFont: .pretendardSemiBoldXS,
            textColor: .tGray1000)
        view.numberOfLines = 1
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
        
        keywordLabel.snp.makeConstraints { make in
            make.edges.equalTo(borderView).inset(10)
        }
    }
    
}
