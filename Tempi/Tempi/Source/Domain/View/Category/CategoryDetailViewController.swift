//
//  CategoryDetailViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/03.
//

import UIKit

class CategoryDetailViewController: BaseViewController {
    
    let mainView = CategoryDetailView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
