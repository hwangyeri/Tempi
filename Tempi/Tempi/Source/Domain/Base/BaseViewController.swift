//
//  BaseViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        view.backgroundColor = UIColor.systemBackground
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
}

extension UIViewController {

    // MARK: - Hide Keyboard
    
    func hideKeyboardWhenTappedBackground() {
         let tapEvent = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
         tapEvent.cancelsTouchesInView = false
         view.addGestureRecognizer(tapEvent)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
