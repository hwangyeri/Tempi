//
//  SettingHeaderView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/12/31.
//

import UIKit
import SnapKit

final class SettingHeaderView: UIView {
    
    let titleLabel = {
        let view = UILabel()
        view.text = "header"
        view.font = .customFont(.pretendardRegularXS)
        view.textColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
}


