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
        backgroundColor = UIColor.tGray200
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
