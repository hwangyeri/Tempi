//
//  TPopupButton.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit

final class TPopUpButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        
        self.setTitle(text, for: .normal)
        self.setTitleColor(UIColor.systemBackground, for: .normal)
        self.backgroundColor = UIColor.label
        self.layer.cornerRadius = Constant.TPopUp.buttonCornerRadius
        self.titleLabel?.font = .customFont(.pretendardSemiBoldL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


