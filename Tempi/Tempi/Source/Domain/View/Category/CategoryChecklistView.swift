//
//  CategoryChecklistView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/04.
//

import UIKit
import SnapKit

class CategoryChecklistView: BaseView {
    
    let mainLabel = {
       let view = TLabel(
        text: "category_checklist_mainLabel".localized,
        custFont: .pretendardSemiBoldXL,
        textColor: .label)
        return view
    }()
    
    let subLabel = {
       let view = TLabel(
        text: "category_checklist_subLabel".localized,
        custFont: .pretendardRegularM,
        textColor: .tGray900)
        return view
    }()
    
    let checklistNameLabel = {
       let view = TLabel(
        text: "category_checklist_checklistNameLabel".localized,
        custFont: .pretendardBoldXXL,
        textColor: .label)
        return view
    }()
    
    let selectedItemCountLabel = {
       let view = TLabel(
        text: "category_checklist_itemCountLabel".localized,
        custFont: .pretendardSemiBoldS,
        textColor: .tGray900)
        return view
    }()
    
    let totalCountLabel = {
       let view = TLabel(
        text: "category_checklist_totalCountLabel".localized,
        custFont: .pretendardSemiBoldS,
        textColor: .tGray900)
        return view
    }()
    
    let selectAllLabel = {
       let view = TLabel(
        text: "category_checklist_selectAllLabel_selectAll".localized,
        custFont: .pretendardRegularXS,
        textColor: .label)
        return view
    }()
    
    let selectAllCheckBox = {
        let view = TBlankCheckBox()
        return view
    }()
    
    let divider = {
        let view = TDivider()
        return view
    }()
    
    let tButton = {
        let view = TButton(
            text: "category_checklist_tButton".localized
        )
        return view
    }()
    
    lazy var categoryChecklistCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCategoryCheckBoxCollectionLayout())
    
    override func configureHierarchy() {
        [mainLabel, subLabel,
         checklistNameLabel, selectedItemCountLabel, totalCountLabel, selectAllCheckBox, selectAllLabel, divider,
         categoryChecklistCollectionView, tButton].forEach {
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
        
        checklistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(40)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        
        selectedItemCountLabel.snp.makeConstraints { make in
            make.top.equalTo(checklistNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(checklistNameLabel).offset(2)
        }
        
        totalCountLabel.snp.makeConstraints { make in
            make.top.equalTo(checklistNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(selectedItemCountLabel.snp.trailing)
        }
        
        selectAllCheckBox.snp.makeConstraints { make in
            make.bottom.equalTo(selectedItemCountLabel.snp.bottom)
            make.trailing.equalTo(self.safeAreaInsets).inset(25)
            make.size.equalTo(32)
        }
        
        selectAllLabel.snp.makeConstraints { make in
            make.centerY.equalTo(selectAllCheckBox)
            make.trailing.equalTo(selectAllCheckBox.snp.leading).offset(-8)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(selectAllCheckBox.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        categoryChecklistCollectionView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(25)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(40)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.45)
        }
        
//        categoryChecklistCollectionView.backgroundColor = .lightGray
        
        tButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(55)
        }
    }
    
    private func configureCategoryCheckBoxCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
}
