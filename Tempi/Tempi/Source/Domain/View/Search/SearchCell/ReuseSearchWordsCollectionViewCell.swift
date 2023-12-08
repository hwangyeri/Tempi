//
//  KeywordCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/02.
//

import UIKit
import SnapKit

final class ReuseSearchWordsCollectionViewCell: BaseCollectionViewCell {
    
    let borderView = {
        let view = UIView()
        view.layer.borderWidth = Constant.TKeywordBorder.borderWidth
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.cornerRadius = Constant.TKeywordBorder.cornerRadius
        view.backgroundColor = UIColor.systemBackground
        return view
    }()

    let searchWordsLabel = {
        let view = TLabel(
            text: "test",
            custFont: .pretendardSemiBoldXS,
            textColor: .label)
        view.numberOfLines = 1
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureHierarchy() {
        self.addSubview(borderView)
        borderView.addSubview(searchWordsLabel)
    }
    
    override func configureLayout() {
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchWordsLabel.snp.makeConstraints { make in
            make.edges.equalTo(borderView).inset(10)
        }
    }
    
}
