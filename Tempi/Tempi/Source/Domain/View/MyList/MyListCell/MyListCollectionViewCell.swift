//
//  MyListCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/21.
//

import UIKit
import SnapKit

class MyListCollectionViewCell: BaseCollectionViewCell {
    
    let checklistBackgroundButton = {
        let view = UIButton()
        view.layer.cornerRadius = Constant.TMyList.cornerRadius
        view.layer.borderWidth = Constant.TMyList.borderWidth
        view.layer.borderColor = UIColor.tertiaryLabel.cgColor
        view.backgroundColor = UIColor.systemBackground
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let checklistNameLabel = {
       let view = TLabel(
        text: "test",
        custFont: .pretendardMediumM,
        textColor: .label
       )
        return view
    }()
    
    let checklistDateLabel = {
       let view = TLabel(
        text: "test",
        custFont: .pretendardRegularXS,
        textColor: .secondaryLabel
       )
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
        contentView.addSubview(checklistBackgroundButton)
        
        [checklistNameLabel, checklistDateLabel, chevronImageView].forEach {
            checklistBackgroundButton.addSubview($0)
        }
    }
    
    override func configureLayout() {
        contentView.backgroundColor = .listBackground
        
        checklistBackgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        checklistNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(checklistBackgroundButton.snp.centerY).inset(6)
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalTo(chevronImageView.snp.leading)
        }
        
        checklistDateLabel.snp.makeConstraints { make in
            make.top.equalTo(checklistNameLabel.snp.bottom)
            make.horizontalEdges.equalTo(checklistNameLabel)
            make.bottom.equalToSuperview().inset(10)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(20)
        }
    }
    
}

