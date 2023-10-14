//
//  ChecklistView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit
import SnapKit

class ChecklistView: BaseView {
    
    let exitButton = {
        let view = TImageButton(
            imageSize: 23,
            imageName: Constant.SFSymbol.xmarkIcon,
            imageColor: .tGray1000
        )
//        let imageConfig = UIImage.SymbolConfiguration(pointSize: 23, weight: .semibold)
//        let image = UIImage(systemName: Constant.SFSymbol.xmarkIcon, withConfiguration: imageConfig)
//        view.setImage(image, for: .normal)
        return view
    }()
    
    let checklistNameLabel = {
       let view = TLabel(
        text: "checklist_checklistNameLabel".localized,
        custFont: .pretendardBoldXXL,
        textColor: .tGray1000
       )
        return view
    }()
    
    let checklistDateLabel = {
       let view = TLabel(
        text: "checklist_checklistDateLabel".localized,
        custFont: .pretendardMediumS,
        textColor: .tGray600
       )
        return view
    }()
    
    let checklistNameEditButton = {
        let view = TImageButton(
            imageSize: 23,
            imageName: Constant.SFSymbol.checklistNameEditIcon,
            imageColor: .tGray1000
        )
        return view
    }()
    
    let checklistBookmarkButton = {
        let view = TImageButton(
            imageSize: 23,
            imageName: Constant.SFSymbol.checklistBookmarkUnFixedIcon,
            imageColor: .tGray1000
        )
        return view
    }()
    
    let checklistDeleteButton = {
        let view = TImageButton(
            imageSize: 23,
            imageName: Constant.SFSymbol.checklistDeleteIcon,
            imageColor: .tGray1000
        )
        return view
    }()
    
    let divider = {
        let view = TDivider()
        return view
    }()
    
    lazy var checklistCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureChecklistCollectionLayout())
    
    let bookmarkListButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: Constant.SFSymbol.bookmarkListIcon), for: .normal)
        view.setTitleColor(.tGray1000, for: .normal)
        view.tintColor = UIColor.tGray1000
        view.layer.cornerRadius = Constant.TBookmarkListButton.cornerRadius
        view.layer.borderColor = UIColor.tGray1000.cgColor
        view.layer.borderWidth = Constant.TBookmarkListButton.borderWidth
        var config = UIButton.Configuration.plain()
        let title = "checklist_bookmarkListButton".localized
        config.imagePadding = Constant.TBookmarkListButton.imagePadding
        config.imagePlacement = .trailing
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.customFont(.pretendardSemiBoldL)!]))
        view.configuration = config
        return view
    }()
    
    override func configureHierarchy() {
        [exitButton, checklistNameLabel, checklistDateLabel, checklistNameEditButton,
         checklistBookmarkButton, checklistDeleteButton, divider, checklistCollectionView, bookmarkListButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        exitButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        
        checklistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(50)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        
        checklistDateLabel.snp.makeConstraints { make in
            make.top.equalTo(checklistNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(checklistNameLabel)
        }
        
        checklistNameEditButton.snp.makeConstraints { make in
            make.leading.equalTo(checklistNameLabel.snp.trailing).offset(8)
            make.bottom.equalTo(checklistNameLabel.snp.bottom)
        }
        
        checklistBookmarkButton.snp.makeConstraints { make in
            make.top.equalTo(checklistDateLabel.snp.bottom).offset(10)
//            make.leading.equalTo(checklistNameEditButton.snp.trailing).offset(65)
            make.trailing.equalTo(checklistDeleteButton.snp.leading).offset(-8)
        }
        
        checklistDeleteButton.snp.makeConstraints { make in
            make.top.equalTo(checklistBookmarkButton).offset(-1)
//            make.leading.equalTo(checklistBookmarkButton.snp.trailing).offset(8)
            make.trailing.equalTo(exitButton.snp.trailing)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(checklistDeleteButton.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        checklistCollectionView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(30)
            make.leading.equalTo(checklistNameLabel)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(80)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        
//        checklistCollectionView.backgroundColor = .lightGray
        
        bookmarkListButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(25)
            make.trailing.equalTo(checklistCollectionView.snp.trailing)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
    }
    
    private func configureChecklistCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
}
