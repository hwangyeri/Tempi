//
//  CategoryChecklistCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit
import SnapKit

class CategoryChecklistCollectionViewCell: BaseCollectionViewCell {
    
    let checkBoxButton = {
        let view = TBlankCheckBox()
        return view
    }()
    
    let checkBoxLabel = {
        let view = TLabel(
            text: "test",
            custFont: .pretendardRegularL,
            textColor: .tGray1000)
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(checkBoxButton)
        contentView.addSubview(checkBoxLabel)
    }
    
    override func configureLayout() {
        checkBoxButton.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView)
            make.size.equalTo(35)
        }
        
        checkBoxLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkBoxButton)
            make.leading.equalTo(checkBoxButton.snp.trailing).offset(10)
        }
    }
    
}
