//
//  AddChecklistView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/11.
//

import UIKit
import SnapKit

class AddChecklistView: BaseView {
    
    let mainLabel = {
       let view = TLabel(
        text: "add_checklist_mainLabel".localized,
        custFont: .pretendardSemiBoldXXL,
        textColor: .label
       )
        return view
    }()
    
    let subLabel = {
        let view = TLabel(
         text: "add_checklist_subLabel".localized,
         custFont: .pretendardRegularS,
         textColor: .secondaryLabel
        )
        view.setAttributedTextWithLineSpacing("add_checklist_subLabel".localized, lineSpacing: 3)
         return view
    }()
    
    lazy var addChecklistCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureAddChecklistCollectionLayout())
    
    let addToNewListButton = {
        let view = UIButton()
        view.layer.cornerRadius = Constant.TChecklist.cornerRadius
        view.layer.borderWidth = Constant.TChecklist.borderWidth
        view.layer.borderColor = UIColor.tertiaryLabel.cgColor
        view.clipsToBounds = true
        view.setTitleColor(.label, for: .normal)
        view.tintColor = UIColor.label
        
        let title = "add_checklist_addToNewListButton_text".localized
        var config = UIButton.Configuration.plain()
        config.imagePadding = Constant.TChecklist.imagePadding
        config.image = UIImage(systemName: Constant.SFSymbol.plusSquareIcon)
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: Constant.TChecklist.symbolPointSize)
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.customFont(.pretendardSemiBoldM)!]))
        config.baseBackgroundColor = UIColor.systemBackground
        view.configuration = config
        return view
    }()

    let addButton = {
        let view = TButton(
            text: "add_checklist_addButton_text".localized
        )
        view.titleLabel?.font = .customFont(.pretendardSemiBoldL)
//        view.backgroundColor = .black
        return view
    }()
    
    override func configureHierarchy() {
        [mainLabel, subLabel, addChecklistCollectionView, addToNewListButton, addButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        mainLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(mainLabel)
        }
        
        addChecklistCollectionView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        addChecklistCollectionView.backgroundColor = .listBackground
        
        addToNewListButton.snp.makeConstraints { make in
            make.top.equalTo(addChecklistCollectionView.snp.bottom).offset(20)
            make.bottom.equalTo(addButton.snp.top).offset(-20)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(25)
            make.height.equalTo(60)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(addToNewListButton)
            make.height.equalTo(60)
        }
    }
    
    private func configureAddChecklistCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
}
