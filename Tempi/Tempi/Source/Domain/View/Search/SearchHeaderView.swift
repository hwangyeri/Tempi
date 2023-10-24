//
//  SearchHeaderView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/22.
//

import UIKit
import SnapKit

class SearchHeaderView: BaseCollectionReusableView {
    
    let titleLabel = {
        let view = TLabel(
            text: "header",
            custFont: .pretendardBoldS,
            textColor: .tGray1000
        )
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(titleLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalToSuperview()
        }
    }
    
}
