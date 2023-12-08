//
//  CategoryCollectionViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/02.
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.tintColor = .tColor(.homeImage)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let textLabel = {
        let view = TLabel(
            text: "test",
            custFont: .pretendardSemiBoldS,
            textColor: .home
        )
        view.textAlignment = .center
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(30)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
}
