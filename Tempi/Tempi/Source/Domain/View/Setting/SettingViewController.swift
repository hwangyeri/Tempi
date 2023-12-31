//
//  SetupViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/23.
//

import UIKit

final class SettingViewController: BaseViewController {
    
    let mainView = SettingView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
