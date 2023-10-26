//
//  BookmarkListCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/25.
//

import UIKit
import SnapKit

class BookmarkListCollectionViewCell: BaseCollectionViewCell {
    
    let checkBoxButton = {
        let view = TBlankCheckBox()
        return view
    }()
    
    let checkBoxLabel = {
        let view = TLabel(
            text: "test",
            custFont: .pretendardRegularL,
            textColor: .label)
        return view
    }()
    
    let deleteButton = {
        let view = TImageButton(
            imageSize: Constant.TImageButton.bookmarkDeleteImageSize,
            imageName: Constant.SFSymbol.checklistDeleteIcon,
            imageColor: .label)
        return view
    }()
    
    override func configureHierarchy() {
        [checkBoxButton, checkBoxLabel, deleteButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        checkBoxButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        
        checkBoxLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkBoxButton)
            make.leading.equalTo(checkBoxButton.snp.trailing).offset(20)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(checkBoxLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(15)
        }
    }
    
}
