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
        text: "category_checklist_main_label".localized,
        custFont: .pretendardSemiBoldXL,
        textColor: .tGray1000)
        return view
    }()
    
    let subLabel = {
       let view = TLabel(
        text: "category_checklist_sub_label".localized,
        custFont: .pretendardRegularM,
        textColor: .tGray900)
        return view
    }()
    
    let checklistNameLabel = {
       let view = TLabel(
        text: "category_checklist_name_label".localized,
        custFont: .pretendardBoldXXL,
        textColor: .tGray1000)
        return view
    }()
    
    let itemCountLabel = {
       let view = TLabel(
        text: "category_checklist_item_count_label".localized,
        custFont: .pretendardBoldS,
        textColor: .tGray600)
        return view
    }()
    
    let selectAllLabel = {
       let view = TLabel(
        text: "category_checklist_select_all_label".localized,
        custFont: .pretendardRegularXS,
        textColor: .tGray1000)
        return view
    }()
    
    let blankCheckBox = {
        let view = TBlankCheckBox()
        return view
    }()
    
    let divider = {
        let view = TDivider()
        return view
    }()
    
    let tButton = {
        let view = TButton(
            text: "category_checklist_tButton_text".localized
        )
        return view
    }()
    
    lazy var categoryChecklistCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCategoryCheckBoxCollectionLayout())
    
    override func configureHierarchy() {
        [mainLabel, subLabel,
         checklistNameLabel, itemCountLabel, blankCheckBox, selectAllLabel, divider,
         tButton, categoryChecklistCollectionView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        mainLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.leading.equalTo(mainLabel)
        }
        
        checklistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(50)
            make.leading.equalTo(mainLabel)
        }
        
        itemCountLabel.snp.makeConstraints { make in
            make.top.equalTo(checklistNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(mainLabel)
        }
        
        blankCheckBox.snp.makeConstraints { make in
            make.bottom.equalTo(itemCountLabel.snp.bottom)
            make.leading.equalTo(selectAllLabel.snp.trailing).offset(8)
            make.size.equalTo(35)
        }
        
        selectAllLabel.snp.makeConstraints { make in
            make.centerY.equalTo(blankCheckBox)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.centerX).offset(80)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(blankCheckBox.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        categoryChecklistCollectionView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(25)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(40)
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
