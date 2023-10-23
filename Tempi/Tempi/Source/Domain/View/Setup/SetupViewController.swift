//
//  SetupViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/23.
//

import UIKit

class SetupViewController: BaseViewController {
    
    let mainView = SetupView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
