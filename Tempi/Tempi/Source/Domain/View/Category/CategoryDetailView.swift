//
//  CategoryDetailView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/03.
//

import UIKit
import SnapKit

class CategoryDetailView: BaseView {
    
    let mainLabel = {
       let view = TLabel(
        text: "category_detail_main_label".localized,
        custFont: .pretendardSemiBoldXXL,
        textColor: .tGray1000)
        return view
    }()
    
    let subLabel = {
       let view = TLabel(
        text: "category_detail_sub_label".localized,
        custFont: .pretendardRegularXL,
        textColor: .tGray900)
        return view
    }()
    
    lazy var subCategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureSubCategoryCollectionLayout())
    
    let nextButton = {
        let view = TButton(
            text: "다음"
        )
        return view
    }()

    override func configureHierarchy() {
        [mainLabel, subLabel, subCategoryCollectionView, nextButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        mainLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.leading.equalTo(mainLabel)
        }
        
        subCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(30)
            make.leading.equalTo(mainLabel)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(100)
        }
        
        subCategoryCollectionView.backgroundColor = .lightGray
        
        nextButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(55)
        }
    }
    
    private func configureSubCategoryCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
}
