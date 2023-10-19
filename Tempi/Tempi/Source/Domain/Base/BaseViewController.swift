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
