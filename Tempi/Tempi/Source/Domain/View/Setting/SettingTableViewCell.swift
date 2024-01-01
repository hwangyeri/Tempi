//
//  SettingTableViewCell.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/12/31.
//

import UIKit
import SnapKit

final class SettingTableViewCell: BaseTableViewCell {
    
    let titleLabel = TLabel(
        text: "설정",
        custFont: .pretendardRegularS,
        textColor: .label
    )
    
    let chevronImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .label
        view.contentMode = .scaleAspectFit
        return view
    }()

    override func configureHierarchy() {
        [titleLabel, chevronImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(18)
            make.leading.equalToSuperview().inset(12)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(16)
        }
    }

}
