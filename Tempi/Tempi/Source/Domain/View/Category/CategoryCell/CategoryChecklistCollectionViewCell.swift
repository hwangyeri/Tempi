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
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let checkBoxLabel = {
        let view = TLabel(
            text: "test",
            custFont: .pretendardRegularL,
            textColor: .label)
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(checkBoxButton)
        contentView.addSubview(checkBoxLabel)
    }
    
    override func configureLayout() {
        checkBoxButton.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView)
            make.size.equalTo(30)
        }
        
        checkBoxLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkBoxButton)
            make.leading.equalTo(checkBoxButton.snp.trailing).offset(12)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
