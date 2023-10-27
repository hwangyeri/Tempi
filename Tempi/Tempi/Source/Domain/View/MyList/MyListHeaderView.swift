//
//  MyListHeaderView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/21.
//

import UIKit
import SnapKit

class MyListHeaderView: BaseCollectionReusableView {
    
    let imageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: Constant.SFSymbol.checklistFixedIcon)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let titleLabel = {
        let view = TLabel(
            text: "",
            custFont: .pretendardBoldS,
            textColor: .tGray1000
        )
        return view
    }()
    
    override func configureHierarchy() {
        [imageView, titleLabel].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(1)
            make.leading.equalToSuperview().inset(15)
            make.size.equalTo(13)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(2)
            make.leading.equalTo(imageView.snp.trailing).offset(6)
        }
    }
    
    func updateLayoutForHiddenImage(isHidden: Bool) {
        imageView.isHidden = isHidden
        if isHidden {
            titleLabel.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(2)
                make.leading.equalToSuperview().inset(20)
            }
        } else {
            titleLabel.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(2)
                make.leading.equalTo(imageView.snp.trailing).offset(6)
            }
        }
    }
    
}
