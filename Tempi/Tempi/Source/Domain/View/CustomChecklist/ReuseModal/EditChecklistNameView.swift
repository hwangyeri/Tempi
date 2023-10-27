//
//  EditChecklistNameView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import SnapKit

class EditChecklistNameView: BaseView {
    
    let exitButton = {
        let view = TImageButton(
            imageSize: Constant.TImageButton.editChecklistNameImageSize,
            imageName: Constant.SFSymbol.xmarkIcon,
            imageColor: .label
        )
        return view
    }()
    
    let mainLabel = {
        // FIXME: 다국어 설정
       let view = TLabel(
        text: "체크리스트의 이름을 입력해 주세요.",
        custFont: .pretendardSemiBoldXXL,
        textColor: .label)
        return view
    }()
    
    let subLabel = {
        // FIXME: 다국어 설정, 텍스트 수정
        let view = TLabel(
         text: "완료 버튼을 눌러야 새로운 이름으로 변경할 수 있어요!",
         custFont: .pretendardRegularM,
         textColor: .point)
         return view
    }()
    
    let textFieldLabel = {
        // FIXME: 다국어 설정
        let view = TLabel(
         text: "체크리스트 이름",
         custFont: .pretendardRegularXS,
         textColor: .tGray700)
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
    
    let editButton = {
        // FIXME: 다국어 설정, 텍스트 분기처리 (완료/다음)
        let view = TButton(
            text: "완료"
        )
        return view
    }()
    
    override func configureHierarchy() {
        [exitButton, mainLabel, subLabel, textFieldLabel, textField, divider, editButton].forEach {
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
            make.top.equalTo(mainLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(mainLabel)
        }
        
        textFieldLabel.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(15)
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
