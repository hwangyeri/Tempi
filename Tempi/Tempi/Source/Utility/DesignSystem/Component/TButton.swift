//
//  TButton.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/04.
//

import UIKit

final class TButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        
        self.setTitle(text, for: .normal)
        self.setTitleColor(UIColor.systemBackground, for: .normal)
        self.layer.cornerRadius = Constant.TButton.cornerRadius
        self.titleLabel?.font = .customFont(.pretendardSemiBoldXL)
        self.backgroundColor = .tButtonDisable
        self.isEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


