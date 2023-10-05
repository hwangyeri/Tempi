//
//  SearchView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let searchBar = {
        let view = UISearchBar()
        view.searchBarStyle = .minimal
        view.placeholder = "search_searchBar_placeholder".localized
        view.searchTextField.font = .customFont(.pretendardRegularM)
        return view
    }()
    
    let recentSearchWordsLabel = {
        let view = TLabel(
            text: "search_recent_search_words_label".localized,
            custFont: .pretendardBoldS,
            textColor: .tGray1000)
        return view
    }()
    
    lazy var recentSearchWordsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureRecentSearchWordsCollectionLayout())
    
    let recommendSearchWordsLabel = {
        let view = TLabel(
            text: "search_recommend_search_words_label".localized,
            custFont: .pretendardBoldS,
            textColor: .tGray1000)
        return view
    }()
    
    lazy var recommendSearchWordsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureRecommendSearchWordsCollectionLayout())
    
    override func configureHierarchy() {
        [searchBar, recentSearchWordsLabel, recentSearchWordsCollectionView, recommendSearchWordsLabel, recommendSearchWordsCollectionView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        recentSearchWordsLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(searchBar).inset(10)
        }
        
        recentSearchWordsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchWordsLabel.snp.bottom).offset(10)
            make.leading.equalTo(recentSearchWordsLabel)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(35)
        }
        
//        recentSearchWordsCollectionView.backgroundColor = .lightGray
        
        recommendSearchWordsLabel.snp.makeConstraints { make in
            make.top.equalTo(recentSearchWordsCollectionView.snp.bottom).offset(20)
            make.leading.equalTo(recentSearchWordsLabel)
        }
        
        recommendSearchWordsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendSearchWordsLabel.snp.bottom).offset(10)
            make.leading.equalTo(recentSearchWordsLabel)
            make.trailing.equalTo(recentSearchWordsCollectionView)
            make.height.equalTo(recentSearchWordsCollectionView)
        }
        
//        recommendSearchWordsCollectionView.backgroundColor = .lightGray
        
    }
    
    private func configureRecentSearchWordsCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 5)
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 0
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
    private func configureRecommendSearchWordsCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 5)
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 0
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
}
