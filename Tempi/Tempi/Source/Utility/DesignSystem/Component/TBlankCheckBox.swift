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
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.borderColor = UIColor.tGray1000.cgColor
        backgroundColor = UIColor.tGray100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

