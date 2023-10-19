//
//  BookmarkListViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/13.
//

import UIKit

class BookmarkListViewController: BaseViewController {
    
    let mainView = BookmarkListView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.selectedItemCountLabel.text = "bookmarkList_selectedItemCountLabel".localized(with: 30)
    }
    
}
