//
//  EditChecklistNameView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import SnapKit

final class EditChecklistNameView: BaseView {
    
    let exitButton = {
        let view = TImageButton(
            imageSize: Constant.TImageButton.editChecklistNameImageSize,
            imageName: Constant.SFSymbol.xmarkIcon,
            imageColor: .label
        )
        return view
    }()
    
    let mainLabel = {
       let view = TLabel(
        text: "editChecklistName_mainLabel".localized,
        custFont: .pretendardBoldXL,
        textColor: .point)
        return view
    }()
    
    let subLabel = {
        let view = TLabel(
         text: "editChecklistName_subLabel".localized,
         custFont: .pretendardSemiBoldXXL,
         textColor: .label)
         return view
    }()
    
    let textFieldLabel = {
        let view = TLabel(
         text: "editChecklistName_textFieldLabel".localized,
         custFont: .pretendardRegularXS,
         textColor: .secondaryLabel)
         return view
    }()
    
    let textField = {
        let view = UITextField()
        return view
    }()
    
    let divider = {
        let view = TDivider()
        view.backgroundColor = UIColor.point
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
        text: " / 60",
        custFont: .pretendardRegularXS,
        textColor: .label)
        return view
    }()
    
    let editButton = {
        let view = TButton(
            text: "editChecklistName_editButton".localized
        )
        return view
    }()
    
    override func configureHierarchy() {
        [exitButton, mainLabel, subLabel, textFieldLabel, textField, divider, currentNumberOfCharactersLabel, maximumNumberOfCharactersLabel, editButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.trailing.equalToSuperview().inset(20)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(exitButton.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(mainLabel)
        }
        
        textFieldLabel.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(45)
            make.leading.equalTo(mainLabel)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(textFieldLabel.snp.bottom)
            make.horizontalEdges.equalTo(mainLabel)
            make.height.equalTo(50)
        }
//        textField.backgroundColor = .lightGray
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.horizontalEdges.equalTo(mainLabel)
            make.height.equalTo(2)
        }
        
        currentNumberOfCharactersLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(10)
            make.leading.equalTo(textFieldLabel)
        }
        
        maximumNumberOfCharactersLabel.snp.makeConstraints { make in
            make.top.equalTo(currentNumberOfCharactersLabel)
            make.leading.equalTo(currentNumberOfCharactersLabel.snp.trailing)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    
    func updateButtonConstraints(keyboardHeight: CGFloat) {
        editButton.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().inset(keyboardHeight + 15)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    
}
