//
//  TDivider.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/04.
//

import UIKit

final class TDivider: UIView {
    
    init() {
        super.init(frame: .zero)
       
        self.backgroundColor = .divider
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
