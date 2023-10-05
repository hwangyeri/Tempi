//
//  SearchViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let dummyList = ["이모티콘", "새싹", "추석", "햄버거", "컬렉션뷰 레이아웃"]
    
    let mainView = SearchView()
    
    private var recentSearchWordsDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    private var recommendSearchWordsDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRecentSearchWordsDataSource()
        configureRecommendSearchWordsDataSource()
    }
    
    private func configureRecentSearchWordsDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ReuseSearchWordsCollectionViewCell, String> {
            cell, indexPath, itemIdentifier in
            cell.searchWordsLabel.text = itemIdentifier
        }
        
        recentSearchWordsDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.recentSearchWordsCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(dummyList)
        recentSearchWordsDataSource.apply(snapshot)
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
        snapshot.appendItems(dummyList)
        recommendSearchWordsDataSource.apply(snapshot)
    }
    
}
