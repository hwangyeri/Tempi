//
//  AddChecklistCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/11.
//

import UIKit
import SnapKit

final class AddChecklistCollectionViewCell: BaseCollectionViewCell {
    
    let checklistButton = {
        let view = UIButton()
        view.layer.cornerRadius = Constant.TChecklist.cornerRadius
        view.layer.borderWidth = Constant.TChecklist.borderWidth
        view.layer.borderColor = UIColor.tertiaryLabel.cgColor
        view.setTitleColor(.label, for: .normal)
                view.setTitle("test", for: .normal)
        view.titleLabel?.font = .customFont(.pretendardSemiBoldM)
        view.backgroundColor = UIColor.systemBackground
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(checklistButton)
    }
    
    override func configureLayout() {
        checklistButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
        
        contentView.backgroundColor = .listBackground
    }
    
}
