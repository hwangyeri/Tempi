//
//  ChecklistCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit
import SnapKit

class ChecklistCollectionViewCell: BaseCollectionViewCell {
    
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
    
    let checkBoxMemoLabel = {
        let view = TLabel(
            text: "test",
            custFont: .pretendardRegularS,
            textColor: .secondaryLabel)
        view.numberOfLines = 1
        return view
    }()
    
//    let checkBoxAlarmImageView = {
//        let view = UIImageView()
//        view.image = UIImage(systemName: Constant.SFSymbol.alarmIcon)
//        view.tintColor = UIColor.point
//        return view
//    }()
//    
//    let checkBoxAlarmLabel = {
//        let view = TLabel(
//            text: "test",
//            custFont: .pretendardBoldXXS,
//            textColor: .point)
//        view.numberOfLines = 1
//        return view
//    }()
    
    let checkBoxMenuButton = {
        let view = TImageButton(
            imageSize: Constant.TImageButton.checklistCollectionCellImageSize,
            imageName: Constant.SFSymbol.checkboxMenuIcon,
            imageColor: .label)
        view.showsMenuAsPrimaryAction = true // long press 없이 한 번의 탭으로 메뉴 나오게 설정
        return view
    }()
    
    override func configureHierarchy() {
        [checkBoxButton, checkBoxLabel, checkBoxMemoLabel, checkBoxMenuButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        checkBoxButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(30)
        }
        
        checkBoxLabel.snp.makeConstraints { make in
            make.top.equalTo(checkBoxButton.snp.top).inset(5)
            make.leading.equalTo(checkBoxButton.snp.trailing).offset(20)
        }
        
        checkBoxMemoLabel.snp.makeConstraints { make in
            make.top.equalTo(checkBoxLabel.snp.bottom).offset(3)
            make.leading.equalTo(checkBoxLabel).offset(1)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
//        checkBoxAlarmImageView.snp.makeConstraints { make in
//            make.top.equalTo(checkBoxMemoLabel.snp.bottom).offset(5)
//            make.leading.equalTo(checkBoxMemoLabel)
//            make.height.equalTo(15)
//            make.width.equalTo(14)
//        }
//        checkBoxAlarmImageView.backgroundColor = .yellow
//        
//        checkBoxAlarmLabel.snp.makeConstraints { make in
//            make.top.equalTo(checkBoxAlarmImageView)
//            make.leading.equalTo(checkBoxAlarmImageView.snp.trailing).offset(3)
//            make.trailing.equalTo(checkBoxLabel)
//        }
//        checkBoxAlarmLabel.backgroundColor = .red
        
        checkBoxMenuButton.snp.makeConstraints { make in
            make.centerY.equalTo(checkBoxButton)
            make.trailing.equalToSuperview()
            make.leading.equalTo(checkBoxLabel.snp.trailing).offset(10)
            make.size.equalTo(40)
        }
    }
    
}
