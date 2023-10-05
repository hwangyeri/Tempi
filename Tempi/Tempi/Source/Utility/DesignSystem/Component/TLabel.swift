//
//  UILabel.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/01.
//

import UIKit

final class TLabel: UILabel {
    
    init(text: String, custFont: UIFont.CustomFont, textColor: UIColor) {
        super.init(frame: .zero)
       
        self.text = text
        self.font = .customFont(custFont)
        self.textColor = textColor
        self.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

