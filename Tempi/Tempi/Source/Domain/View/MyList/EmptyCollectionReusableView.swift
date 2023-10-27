//
//  EmptyCollectionReusableView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/22.
//

import UIKit
import SnapKit

class EmptyCollectionReusableView: BaseCollectionReusableView {
        
    let imageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: Constant.SFSymbol.checkIcon)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let mainLabel = {
        let view = TLabel(
            text: "빈 화면 메인 라벨입니다.",
            custFont: .pretendardSemiBoldL,
            textColor: .label
        )
        return view
    }()
    
    let subLabel = {
        let view = TLabel(
            text: "빈 화면 서브 라벨입니다.",
            custFont: .pretendardRegularS,
            textColor: .label
        )
        return view
    }()
    
    let textLabel = {
        let view = TLabel(
            text: "",
            custFont: .pretendardRegularS,
            textColor: .label
        )
        return view
    }()
    
    override func configureHierarchy() {
//        [imageView, mainLabel, subLabel].forEach {
//            addSubview($0)
//        }
        addSubview(textLabel)
        self.backgroundColor = .red
    }
    
    override func configureLayout() {
//        imageView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.size.equalTo(50)
//        }
//        
//        mainLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.top.equalTo(imageView.snp.bottom).offset(20)
//        }
//        
//        subLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.top.equalTo(mainLabel.snp.bottom).offset(10)
//        }
        textLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
}
