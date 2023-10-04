//
//  CategoryDetailViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/03.
//

import UIKit

class CategoryDetailViewController: BaseViewController {
    
    let dummyList = ["일본 여행", "국내 여행", "djdjdjdjdjdjdjdnjdndjfd dnjdjd수영장", "어쩌구 저쩌구 호캉스", "어쩌구 휴양지", "2자"]
    
    let mainView = CategoryDetailView()
    
    private var subCategoryDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubCategoryDataSource()
    }
    
    private func configureSubCategoryDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SubCategoryCollectionViewCell, String> {
            cell, indexPath, itemIdentifier in
            cell.textLabel.text = itemIdentifier
        }
        
        subCategoryDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.subCategoryCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(dummyList)
        subCategoryDataSource.apply(snapshot)
    }
    
}
