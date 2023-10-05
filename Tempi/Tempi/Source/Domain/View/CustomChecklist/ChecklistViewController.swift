//
//  ChecklistViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit

class ChecklistViewController: BaseViewController {
    
    let dummyList = ["수영복", "수경", "djdjdjdjdjdjdjddmfksdfknsdkfndsklnfnjdndjfd dnjdjd", "워터프루프 선크림"]
    
    let mainView = ChecklistView()
    
    private var checklistDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureChecklistDataSource()
    }
    
    private func configureChecklistDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ChecklistCollectionViewCell, String> {
            cell, indexPath, itemIdentifier in
            cell.checkBoxLabel.text = itemIdentifier
            cell.checkBoxMemoLabel.text = itemIdentifier
            cell.checkBoxAlarmLabel.text = itemIdentifier
//            cell.backgroundColor = .link
        }
        
        checklistDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.checklistCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(dummyList)
        checklistDataSource.apply(snapshot)
    }

}
