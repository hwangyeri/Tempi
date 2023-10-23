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
        view.layer.cornerRadius = 35
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.tGray400.cgColor
        view.backgroundColor = UIColor.tGray100
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let checklistNameLabel = {
       let view = TLabel(
        text: "test",
        custFont: .pretendardMediumM,
        textColor: .tGray1000
       )
        return view
    }()
    
    let checklistDateLabel = {
       let view = TLabel(
        text: "test",
        custFont: .pretendardRegularXS,
        textColor: .tGray800
       )
        return view
    }()
    
    let chevronImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: Constant.SFSymbol.chevronRightIcon)
        view.contentMode = .scaleAspectFit
        view.tintColor = UIColor.tGray1000
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(checklistBackgroundButton)
        
        [checklistNameLabel, checklistDateLabel, chevronImageView].forEach {
            checklistBackgroundButton.addSubview($0)
        }
    }
    
    override func configureLayout() {
        contentView.backgroundColor = .tGray200
        
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

