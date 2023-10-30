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
        textColor: .label)
        return view
    }()
    
    let subLabel = {
       let view = TLabel(
        text: "category_detail_sub_label".localized,
        custFont: .pretendardRegularS,
        textColor: .secondaryLabel)
        return view
    }()
    
    lazy var subCategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureSubCategoryCollectionLayout())
    
    let tButton = {
        let view = TButton(
            text: "category_detail_tButton_text".localized
        )
        return view
    }()

    override func configureHierarchy() {
        [mainLabel, subLabel, subCategoryCollectionView, tButton].forEach {
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
            make.trailing.equalToSuperview().inset(10)
        }
        
        subCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(30)
            make.leading.equalTo(mainLabel)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(200)
        }
        
//        subCategoryCollectionView.backgroundColor = .lightGray
        
        tButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(55)
        }
    }
    
    // FIXME: text 길이/전체 컬렉션뷰 가로 길이에 맞춰서 유동적으로 아이템 수가 변하게 수정하기
    private func configureSubCategoryCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10)
        section.interGroupSpacing = 12
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
}
