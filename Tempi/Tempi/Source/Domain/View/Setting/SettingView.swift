//
//  SetupView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/23.
//

import UIKit
import SnapKit

final class SettingView: BaseView {
    
    let tableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.estimatedRowHeight = 100
        view.rowHeight = UITableView.automaticDimension
        view.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        view.backgroundColor = .systemBackground
        return view
    }()
    
    override func configureHierarchy() {
        self.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
   
}
