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
        configure()
        setConstraints()
        view.backgroundColor = UIColor.systemBackground
    }
    
    func configure() { }
    
    func setConstraints() { }
    
}
