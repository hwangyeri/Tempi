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

    override func configureLayout() {
        mainView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    @objc private func plusButtonTapped() {
        print(#function)
        
        showToast(message: "성공적으로 삭제 되었어요!")
    }

}

