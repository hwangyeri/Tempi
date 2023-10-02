//
//  CategoryHomeViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import UIKit
import SnapKit

class CategoryHomeViewController: BaseViewController {
    
    let list = ["이모티콘", "새싹", "추석", "햄버거", "컬렉션뷰 레이아웃"]
    
    let mainView = CategoryHomeView()
    
    private var keywordDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
    }
    
    override func configureHierarchy() {
        mainView.searchBar.delegate = self
    }
    
    private func configureDataSource() {
       
        let cellRegistration = UICollectionView.CellRegistration<KeywordCollectionViewCell, String> { cell, indexPath, itemIdentifier in
            cell.keywordLabel.text = itemIdentifier
        }
        
        keywordDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.keywordCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let listItem = self.list[indexPath.item]
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.keywordLabel.text = listItem
            return cell
        })
        configureSnapshot()
    }
    
    private func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        keywordDataSource.apply(snapshot)
    }

}

// MARK: - SearchBar

extension CategoryHomeViewController: UISearchBarDelegate {
    
}
