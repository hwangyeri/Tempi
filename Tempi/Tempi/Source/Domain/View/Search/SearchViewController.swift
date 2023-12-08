//
//  SearchViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    private var searchResult: [CategoryDefaultData] = []
    
    private let mainView = SearchView()
    
    private var recommendSearchWordsDataSource: UICollectionViewDiffableDataSource<Int, CategoryDefaultData>!
    private var searchResultsDataSource: UICollectionViewDiffableDataSource<Int, CategoryDefaultData>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideBackButtonTitle()
    }
    
    override func configureLayout() {
        configureRecommendSearchWordsDataSource()
        configureSearchResultsDataSource()
        hideKeyboardWhenTappedBackground()
        mainView.searchBar.delegate = self
        mainView.searchBar.becomeFirstResponder()
        mainView.recommendSearchWordsCollectionView.delegate = self
        mainView.searchResultCollectionView.delegate = self
        mainView.searchResultCollectionView.isHidden = true
    }
    
    // MARK: - 추천 검색어 DataSource
    private func configureRecommendSearchWordsDataSource() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<SearchHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { headerView, elementKind, indexPath in
            headerView.titleLabel.text = "search_recommendSearchWords_header".localized
        }
        
        let cellRegistration = UICollectionView.CellRegistration<ReuseSearchWordsCollectionViewCell, CategoryDefaultData> {
            cell, indexPath, itemIdentifier in
            cell.searchWordsLabel.text = itemIdentifier.subCategoryName
        }
        
        let list = DataManager.shared.categoryList
        
        // 중복 제거
        var uniqueList = [CategoryDefaultData]()
        var uniqueSet = Set<String>()
        for item in list {
            if !uniqueSet.contains(item.subCategoryName) {
                uniqueList.append(item)
                uniqueSet.insert(item.subCategoryName)
            }
        }
        
        // 랜덤으로 5개 추출
        var randomList = [CategoryDefaultData]()
        if uniqueList.count > 5 {
            while randomList.count < 5 {
                if let randomItem = uniqueList.randomElement(), !randomList.contains(randomItem) {
                    randomList.append(randomItem)
                }
            }
        } else {
            randomList = uniqueList
        }
        
        recommendSearchWordsDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.recommendSearchWordsCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        recommendSearchWordsDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: IndexPath(item: 0, section: 0))
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryDefaultData>()
        snapshot.appendSections([0])
        snapshot.appendItems(randomList)
        recommendSearchWordsDataSource.apply(snapshot)
    }
    
    // MARK: - 검색 결과 DataSource
    private func configureSearchResultsDataSource() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<SearchHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { headerView, elementKind, indexPath in
            headerView.titleLabel.text = "search_searchResults_header".localized
        }
        
        let cellRegistration = UICollectionView.CellRegistration<SearchResultCollectionViewCell, CategoryDefaultData> { cell, indexPath, itemIdentifier in
            cell.categoryLabel.text = "searchResult_categoryNameLabel".localized(with: itemIdentifier.categoryName)
            cell.subCategoryNameLabel.text = itemIdentifier.subCategoryName
        }
        
        searchResultsDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.searchResultCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        searchResultsDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: IndexPath(item: 0, section: 0))
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryDefaultData>()
        snapshot.appendSections([0])
        snapshot.appendItems(searchResult)
        searchResultsDataSource.apply(snapshot)
    }
    
}

// MARK: - CollectionView Delegate
extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        if collectionView == mainView.searchResultCollectionView {
            handleCellSelection(for: searchResultsDataSource, collectionView: collectionView, indexPath: indexPath)
        } else if collectionView == mainView.recommendSearchWordsCollectionView {
            handleCellSelection(for: recommendSearchWordsDataSource, collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    private func handleCellSelection(for dataSource: UICollectionViewDiffableDataSource<Int, CategoryDefaultData>, collectionView: UICollectionView, indexPath: IndexPath) {
        guard let cell = dataSource.itemIdentifier(for: indexPath) else {
            print("cell error")
            return
        }
        let categoryChecklistVC = CategoryChecklistViewController()
        categoryChecklistVC.categoryName = cell.categoryName
        categoryChecklistVC.subCategoryName = cell.subCategoryName
        navigationController?.pushViewController(categoryChecklistVC, animated: true)
    }
}

// MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 실시간 검색
        DispatchQueue.main.async {
            if searchText.isEmpty {
                self.searchResult = []
                self.mainView.searchResultCollectionView.isHidden = true
                self.mainView.recommendSearchWordsCollectionView.isHidden = false
            } else {
                let filteredList = DataManager.shared.categoryList.filter { category in
                    return category.subCategoryName.lowercased().contains(searchText.lowercased())
                }
                
                // 중복 제거
                var uniqueList = [CategoryDefaultData]()
                var uniqueSet = Set<String>()
                for item in filteredList {
                    if !uniqueSet.contains(item.subCategoryName) {
                        uniqueList.append(item)
                        uniqueSet.insert(item.subCategoryName)
                    }
                }
                
                var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryDefaultData>()
                snapshot.appendSections([0])
                snapshot.appendItems(uniqueList)
                self.searchResultsDataSource.apply(snapshot)
                self.mainView.recommendSearchWordsCollectionView.isHidden = true
                self.mainView.searchResultCollectionView.isHidden = false
            }
        }
    }
    
}
