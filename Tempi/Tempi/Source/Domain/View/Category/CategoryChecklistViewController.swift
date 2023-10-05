//
//  CategoryChecklistViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/04.
//

import UIKit

class CategoryChecklistViewController: BaseViewController {
    
    let dummyList = ["수영복", "수경", "djdjdjdjdjdjdjdnjdndjfd dnjdjd", "워터프루프 선크림"]
    
    let mainView = CategoryChecklistView()
    
    private var categoryChecklistDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubCategoryDataSource()
    }

    private func configureSubCategoryDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CategoryChecklistCollectionViewCell, String> {
            cell, indexPath, itemIdentifier in
            cell.checkBoxLabel.text = itemIdentifier
        }
        
        categoryChecklistDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.categoryChecklistCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(dummyList)
        categoryChecklistDataSource.apply(snapshot)
    }
    
}
