//
//  KeywordCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/02.
//

import UIKit
import SnapKit

class KeywordCollectionViewCell: BaseCollectionViewCell {
    
    // FIXME: Border 가 안보임...

    let keywordLabel = {
        let view = TLabel(
            text: "테스트",
            custFont: .pretendardSemiBoldXS,
            textColor: .tGray1000)
        view.layer.cornerRadius = Constant.TKeywordLabel.cornerRadius
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = Constant.TKeywordLabel.borderWidth
        view.backgroundColor = UIColor.tGray100
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(keywordLabel)
    }
    
    override func configureLayout() {
        keywordLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
}
