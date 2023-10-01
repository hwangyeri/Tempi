//
//  HomeViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let mainLabel = UILabel()
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .tColor(.point)
        navigationItem.title = "temp".localized
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(100)
        }
        mainLabel.text = "안녕하세요"
        mainLabel.font = .customFont(.pretendardSemiBoldL)
        
//        presentDeleteAlert(title: "ddd", message: "ddd") {
//            print(#function)
//        }
        
        datePicker.date = Date()

        let formattedDate = datePicker.formatDate()
        print(formattedDate)
    }


}

