//
//  PopUpView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import SnapKit

class PopUpView: BaseView {
    
    let backView = {
        let view = UIView()
        view.backgroundColor = UIColor.tGray100
        view.layer.cornerRadius = Constant.TPopUp.viewCornerRadius
        return view
    }()
    
    let mainLabel = {
        // FIXME: 다국어 설정
       let view = TLabel(
        text: "정말로 삭제하실 건가요?",
        custFont: .pretendardSemiBoldL,
        textColor: .tGray1000)
        view.textAlignment = .center
        return view
    }()
    
    let subLabel = {
        // FIXME: 다국어 설정
        let view = TLabel(
         text: "삭제된 데이터는 복구가 어려워요...😢",
         custFont: .pretendardRegularS,
         textColor: .tGray1000)
        view.textAlignment = .center
         return view
    }()
    
    let cancelButton = {
        // FIXME: 다국어 설정
        let view = TPopUpButton(
            text: "취소"
        )
        view.backgroundColor = UIColor.tGray700
        return view
    }()
    
    let deleteButton = {
        // FIXME: 다국어 설정
        let view = TPopUpButton(
            text: "삭제"
        )
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(backView)
        
        [mainLabel, subLabel, cancelButton, deleteButton].forEach {
            backView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.3)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(mainLabel)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(40)
            make.bottom.equalToSuperview().inset(30)
            make.leading.equalTo(subLabel.snp.leading).inset(10)
            make.width.equalTo(deleteButton).multipliedBy(1)
            make.height.equalTo(45)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.bottom.equalTo(cancelButton)
            make.leading.equalTo(cancelButton.snp.trailing).offset(10)
            make.trailing.equalTo(subLabel.snp.trailing).inset(10)
            make.height.equalTo(cancelButton)
        }
        
    }
    
}
