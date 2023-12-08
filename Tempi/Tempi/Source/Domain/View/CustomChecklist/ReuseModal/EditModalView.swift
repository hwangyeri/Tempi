//
//  EditModalView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/18.
//

import UIKit
import SnapKit

final class EditModalView: BaseView {
    
    let backView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        view.layer.cornerRadius = 50
        return view
    }()
    
    let mainLabel = {
       let view = TLabel(
        text: "Main Label",
        custFont: .pretendardSemiBoldM,
        textColor: .label)
        view.textAlignment = .center
        return view
    }()
    
    let subLabel = {
        let view = TLabel(
         text: "Sub Label",
         custFont: .pretendardRegularS,
         textColor: .label)
        view.textAlignment = .center
         return view
    }()
    
    let textFieldBackView = {
        let view = UIView()
        view.backgroundColor = UIColor.textFieldBackground
        view.layer.cornerRadius = 15
        return view
    }()
    
    let textField = {
        let view = UITextField()
        view.placeholder = ""
        return view
    }()
    
    let currentNumberOfCharactersLabel = {
       let view = TLabel(
        text: "0",
        custFont: .pretendardRegularXS,
        textColor: .label)
        return view
    }()
    
    let maximumNumberOfCharactersLabel = {
       let view = TLabel(
        text: "Maximum Number Of Characters Label",
        custFont: .pretendardRegularXS,
        textColor: .label)
        return view
    }()
    
    let saveButton = {
        let view = TButton(
            text: "editModal_saveButton".localized
        )
        view.layer.cornerRadius = 25
        view.titleLabel?.font = .customFont(.pretendardSemiBoldM)
        return view
    }()
    
    override func configureHierarchy() {
        [backView, mainLabel, subLabel, textFieldBackView, currentNumberOfCharactersLabel, maximumNumberOfCharactersLabel, saveButton].forEach {
            addSubview($0)
        }
        textFieldBackView.addSubview(textField)
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top).inset(20)
            make.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(30)
        }
        
        textFieldBackView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(55)
        }
        
        textField.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalTo(subLabel)
            make.trailing.equalToSuperview().inset(10)
        }
        
        currentNumberOfCharactersLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldBackView.snp.bottom).offset(10)
            make.leading.equalTo(textField)
            make.bottom.equalTo(saveButton.snp.top).offset(-30)
        }
        
        maximumNumberOfCharactersLabel.snp.makeConstraints { make in
            make.top.equalTo(currentNumberOfCharactersLabel)
            make.leading.equalTo(currentNumberOfCharactersLabel.snp.trailing)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    
    func updateButtonConstraints(keyboardHeight: CGFloat) {
        saveButton.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().inset(keyboardHeight + 15)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
}
