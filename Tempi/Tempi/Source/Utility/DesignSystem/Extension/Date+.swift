//
//  Date+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import UIKit

extension UIDatePicker {
    
    func formatDate(_ format: String = "yyyy.MM.dd a h:mm") -> String { // 2023.09.30 오전 1:00
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self.date)
    }
    
}

