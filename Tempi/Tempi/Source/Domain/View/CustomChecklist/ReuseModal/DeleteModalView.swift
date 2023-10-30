//
//  DeleteModalView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import SnapKit

class DeleteModalView: BaseView {
    
    let backView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        view.layer.cornerRadius = Constant.TPopUp.viewCornerRadius
        return view
    }()
    
    let mainLabel = {
       let view = TLabel(
        text: "deleteModal_mainLabel".localized,
        custFont: .pretendardSemiBoldL,
        textColor: .label)
        view.textAlignment = .center
        return view
    }()
    
    let subLabel = {
        let view = TLabel(
            text: "deleteModal_subLabel".localized,
         custFont: .pretendardRegularS,
         textColor: .label)
        view.textAlignment = .center
         return view
    }()
    
    let cancelButton = {
        let view = TPopUpButton(
            text: "deleteModal_cancelButton".localized
        )
        view.backgroundColor = UIColor.deleteCancel
        return view
    }()
    
    let deleteButton = {
        let view = TPopUpButton(
            text: "deleteModal_deleteButton".localized
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
            make.top.equalToSuperview().inset(25)
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
