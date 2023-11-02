//
//  TBlankBox.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/04.
//

import UIKit

final class TBlankCheckBox: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = Constant.TBlankCheckBox.cornerRadius
        self.layer.borderWidth = Constant.TBlankCheckBox.borderWidth
        self.layer.borderColor = UIColor.label.cgColor
        self.backgroundColor = self.isSelected ? UIColor.label : UIColor.systemBackground
        self.setImage(nil, for: .normal)
        self.setImage(UIImage(systemName: Constant.SFSymbol.checkIcon), for: .selected)
        self.tintColor = .systemBackground
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

