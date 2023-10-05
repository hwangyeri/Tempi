//
//  CategoryHomeView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import UIKit
import SnapKit

class CategoryHomeView: BaseView {
    
    let searchMainLabel = {
       let view = TLabel(
        text: "search_main_label".localized,
        custFont: .pretendardBoldL,
        textColor: .tGray1000)
        return view
    }()
    
    let searchBar = {
        let view = UISearchBar()
        view.searchBarStyle = .minimal // 테두리 없앰
        view.placeholder = "searchBar_placeholder".localized
        view.searchTextField.font = .customFont(.pretendardRegularM)
        return view
    }()
    
    lazy var keywordCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureKeywordCollectionLayout())
    
    let divider = {
        let view = TDivider()
        return view
    }()
    
    let categoryDivider = {
        let view = UIView()
        view.backgroundColor = UIColor.tGray1000
        return view
    }()
    
    let categoryTitleLabel = {
        let view = TLabel(
            text: "category_title_label".localized,
            custFont: .pretendardBlackXL,
            textColor: .tGray1000)
        return view
    }()
 
    let categoryMainLabel = {
        let view = TLabel(
            text: "category_main_label".localized,
            custFont: .pretendardBoldL,
            textColor: .tGray1000)
        return view
    }()
    
    let categorySubLabel = {
        let view = TLabel(
            text: "category_sub_label".localized,
            custFont: .pretendardRegularS,
            textColor: .tGray800)
        view.textAlignment = .center
        return view
    }()
    
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCategoryCollectionLayout())
    
    let plusButton = {
        let view = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .semibold)
        let image = UIImage(systemName: Constant.SFSymbol.plusCircleIcon, withConfiguration: imageConfig)
        view.setImage(image, for: .normal)
        view.tintColor = UIColor.tGray1000
        return view
    }()
    
    override func configureHierarchy() {
        [searchMainLabel, searchBar, keywordCollectionView, divider,
         categoryDivider, categoryTitleLabel, categoryMainLabel, categorySubLabel, categoryCollectionView, plusButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        searchMainLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(searchMainLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        keywordCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.equalTo(searchBar).inset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(35)
        }
        
//        keywordCollectionView.backgroundColor = .lightGray
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(keywordCollectionView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(searchBar).inset(10)
            make.height.equalTo(0.5)
        }
        
        categoryDivider.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(20)
            make.leading.equalTo(divider)
            make.width.equalTo(3)
            make.height.equalTo(categoryTitleLabel)
        }
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryDivider)
            make.leading.equalTo(categoryDivider).offset(10)
        }
        
        categoryMainLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleLabel.snp.bottom).offset(30)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        categorySubLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryMainLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categorySubLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(180)
        }
        
//        categoryCollectionView.backgroundColor = .lightGray
        
        plusButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
        }
    }
    
    private func configureKeywordCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 5)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 0
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
    private func configureCategoryCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 30
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
}
