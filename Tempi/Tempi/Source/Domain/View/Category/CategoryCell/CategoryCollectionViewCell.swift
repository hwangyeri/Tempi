//
//  CategoryCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/02.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.tintColor = UIColor.tGray900
        view.contentMode = .scaleAspectFit
//        view.backgroundColor = .green
        return view
    }()
    
    let textLabel = {
        let view = TLabel(
            text: "test",
            custFont: .pretendardSemiBoldS,
            textColor: .tGray900)
//        view.backgroundColor = .red
        view.textAlignment = .center
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.centerX.equalToSuperview()
            make.size.equalTo(30)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.bottom.horizontalEdges.equalTo(contentView)
        }
    }
    
}
