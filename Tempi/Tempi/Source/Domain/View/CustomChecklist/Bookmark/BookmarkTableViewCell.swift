//
//  BookmarkTableViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/12/09.
//

import UIKit
import SnapKit

final class BookmarkTableViewCell: BaseTableViewCell {
    
    let checkBoxButton = {
        let view = TBlankCheckBox()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let checkBoxLabel = TLabel(
        text: "test",
        custFont: .pretendardRegularL,
        textColor: .label
    )
    
    var isChecked: Bool = false {
        didSet {
            checkBoxButton.isSelected = isChecked
            checkBoxButton.layer.backgroundColor = isChecked ? UIColor.label.cgColor : UIColor.systemBackground.cgColor
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        checkBoxButton.layer.backgroundColor = UIColor.systemBackground.cgColor
        checkBoxButton.isSelected = false
        isChecked = false
    }
    
    override func configureHierarchy() {
        [checkBoxButton, checkBoxLabel].forEach {
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
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
}
