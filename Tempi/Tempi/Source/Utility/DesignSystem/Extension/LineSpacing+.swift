//
//  LineSpacing+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/25.
//

import UIKit

extension UILabel {
    func setAttributedTextWithLineSpacing(_ text: String, lineSpacing: CGFloat) {
        let attrString = NSMutableAttributedString(string: text.localized)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}
