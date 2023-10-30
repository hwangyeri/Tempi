//
//  SearchResultCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/22.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell: BaseCollectionViewCell {
    
    let backgroundButton = {
        let view = UIButton()
        view.layer.cornerRadius = 35
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.backgroundColor = UIColor.systemBackground
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let categoryLabel = {
       let view = TLabel(
        text: "searchResult_categoryNameLabel".localized,
        custFont: .pretendardMediumXS,
        textColor: .secondaryLabel
       )
        view.numberOfLines = 1
        return view
    }()
    
    let subCategoryNameLabel = {
        let view = TLabel(
            text: "searchResult_subCategoryNameLabel".localized,
            custFont: .pretendardMediumM,
            textColor: .label
        )
        view.numberOfLines = 1
        return view
    }()
    
    let chevronImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: Constant.SFSymbol.chevronRightIcon)
        view.contentMode = .scaleAspectFit
        view.tintColor = UIColor.label
        return view
    }()
    
    override func configureHierarchy() {
        self.addSubview(backgroundButton)
        
        [categoryLabel, subCategoryNameLabel, chevronImageView].forEach {
            backgroundButton.addSubview($0)
        }
    }
    
    override func configureLayout() {
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalTo(chevronImageView.snp.leading)
        }
        
        subCategoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(categoryLabel)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(20)
        }
    }
    
}
