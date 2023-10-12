//
//  SubCategoryCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/04.
//

import UIKit
import SnapKit

class SubCategoryCollectionViewCell: BaseCollectionViewCell {
    
    let backView = {
        let view = UIView()
        view.layer.cornerRadius = Constant.TSubCategory.cornerRadius
        view.backgroundColor = UIColor.tGray300
        return view
    }()
    
    let textLabel = {
        let view = TLabel(
            text: "test",
            custFont: .pretendardRegularL,
            textColor: .tGray700)
        view.backgroundColor = UIColor.clear
        view.textAlignment = .center
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(textLabel)
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        textLabel.snp.makeConstraints { make in
            make.edges.equalTo(backView).inset(10)
        }
    }
    
}
