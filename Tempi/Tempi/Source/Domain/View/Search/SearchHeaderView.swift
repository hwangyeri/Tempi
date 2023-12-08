//
//  SearchHeaderView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/22.
//

import UIKit
import SnapKit

final class SearchHeaderView: BaseCollectionReusableView {
    
    let titleLabel = {
        let view = TLabel(
            text: "header",
            custFont: .pretendardBoldS,
            textColor: .label
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
