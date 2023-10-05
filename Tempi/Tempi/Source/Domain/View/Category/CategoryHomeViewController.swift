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
    
    private var recommendSearchWordsDataSource: UICollectionViewDiffableDataSource<Int, String>!
    private var categoryDataSource: UICollectionViewDiffableDataSource<Int, CategoryType>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRecommendSearchWordsDataSource()
        configureCategoryDataSource()
    }
    
    override func configureHierarchy() {
        mainView.searchBar.delegate = self
    }
    
    private func configureRecommendSearchWordsDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ReuseSearchWordsCollectionViewCell, String> {
            cell, indexPath, itemIdentifier in
            cell.searchWordsLabel.text = itemIdentifier
        }
        
        recommendSearchWordsDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.recommendSearchWordsCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        recommendSearchWordsDataSource.apply(snapshot)
    }
    
    private func configureCategoryDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CategoryCollectionViewCell, CategoryType> { cell, indexPath, itemIdentifier in
            cell.imageView.image = itemIdentifier.image
            cell.textLabel.text = itemIdentifier.text
        }
        
        categoryDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.categoryCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let categories: [CategoryType] = CategoryType.categories
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryType>()
        snapshot.appendSections([0])
        snapshot.appendItems(categories)
        categoryDataSource.apply(snapshot)
    }

}

// MARK: - SearchBar

extension CategoryHomeViewController: UISearchBarDelegate {
    
}
