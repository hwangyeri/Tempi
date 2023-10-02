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
        view.searchTextField.font = .customFont(.pretendardSemiBoldM)
        return view
    }()
    
    lazy var keywordCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureTagLayout())
    
    let divider = {
        let view = UIView()
        view.backgroundColor = UIColor.tGray400
        return view
    }()
    
    let categoryTitleLabel = {
        let view = TLabel(
            text: "category_title_label".localized,
            custFont: .pretendardBlackL,
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
            custFont: .pretendardSemiBoldS,
            textColor: .tGray600)
        view.numberOfLines = 2
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
         categoryTitleLabel, categoryMainLabel, categorySubLabel, categoryCollectionView, plusButton].forEach {
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
            make.horizontalEdges.equalTo(searchBar).inset(10)
            make.height.equalTo(30)
        }
        
        keywordCollectionView.backgroundColor = .lightGray
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(keywordCollectionView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(searchBar).inset(10)
            make.height.equalTo(0.5)
        }
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(20)
            make.leading.equalTo(searchMainLabel)
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
            make.top.equalTo(categorySubLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(200)
        }
        
//        categoryCollectionView.backgroundColor = .lightGray
        
        plusButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
        }
    }
    
    private func configureTagLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
        
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
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 60)
        return layout
    }
    
}
