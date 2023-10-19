//
//  HideKeyboard+.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/18.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedBackground() {
         let tapEvent = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
         tapEvent.cancelsTouchesInView = false
         view.addGestureRecognizer(tapEvent)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
