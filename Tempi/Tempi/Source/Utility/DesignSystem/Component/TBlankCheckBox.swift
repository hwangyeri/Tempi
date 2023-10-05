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
        layer.cornerRadius = Constant.TBlankCheckBox
            .cornerRadius
        layer.borderWidth = Constant.TBlankCheckBox.borderWidth
        layer.borderColor = UIColor.tGray1000.cgColor
        backgroundColor = UIColor.tGray100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

