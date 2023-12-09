//
//  ReusableViewProtocol+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/12/09.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
