//
//  MyListViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit
import SnapKit

class MyChecklistViewController: BaseViewController {
    
    let mainView = MyChecklistView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

