//
//  ChecklistView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit
import SnapKit

final class ChecklistView: BaseView {
    
    let checklistNameLabel = {
       let view = TLabel(
        text: "checklist_checklistNameLabel".localized,
        custFont: .pretendardBoldXXXL,
        textColor: .label
       )
        return view
    }()
    
    let checklistDateLabel = {
       let view = TLabel(
        text: "checklist_checklistDateLabel".localized,
        custFont: .pretendardMediumS,
        textColor: .secondaryLabel
       )
        return view
    }()
    
    let checklistNameEditButton = {
        let view = TImageButton(
            imageSize: Constant.TImageButton.checklistImageSize,
            imageName: Constant.SFSymbol.checklistNameEditIcon,
            imageColor: .label
        )
        return view
    }()
    
    let bookmarkListButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: Constant.SFSymbol.bookmarkListIcon), for: .normal)
        view.setTitleColor(.label, for: .normal)
        view.tintColor = UIColor.label
        view.layer.cornerRadius = Constant.TBookmarkListButton.cornerRadius
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = Constant.TBookmarkListButton.borderWidth
        var config = UIButton.Configuration.plain()
        let title = "checklist_bookmarkListButton".localized
        config.imagePadding = Constant.TBookmarkListButton.imagePadding
        config.imagePlacement = .trailing
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont.customFont(.pretendardSemiBoldS)!]))
        view.configuration = config
        return view
    }()
    
    let checklistFixedButton = {
        let view = TImageButton(
            imageSize: Constant.TImageButton.checklistImageSize,
            imageName: Constant.SFSymbol.checklistUnFixedIcon,
            imageColor: .label
        )
        let imageConfig = UIImage.SymbolConfiguration(pointSize: Constant.TImageButton.checklistImageSize, weight: .regular)
        let unFixedImage = UIImage(systemName: Constant.SFSymbol.checklistUnFixedIcon, withConfiguration: imageConfig)
        let fixedImage = UIImage(systemName: Constant.SFSymbol.checklistFixedIcon, withConfiguration: imageConfig)
        view.setImage(unFixedImage, for: .normal)
        view.setImage(fixedImage, for: .selected)
        return view
    }()
    
    let checklistDeleteButton = {
        let view = TImageButton(
            imageSize: Constant.TImageButton.checklistImageSize,
            imageName: Constant.SFSymbol.checklistDeleteIcon,
            imageColor: .label
        )
        return view
    }()
    
    let divider = {
        let view = TDivider()
        return view
    }()
    
    lazy var checklistCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureChecklistCollectionLayout())
    
    let plusButton = {
        let view = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
        let image = UIImage(systemName: Constant.SFSymbol.plusCircleIcon, withConfiguration: imageConfig)
        view.setImage(image, for: .normal)
        view.tintColor = UIColor.label
        return view
    }()
    
    override func configureHierarchy() {
        [checklistNameLabel, checklistDateLabel, checklistNameEditButton, bookmarkListButton, checklistFixedButton, checklistDeleteButton, divider, checklistCollectionView, plusButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        checklistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        
        checklistDateLabel.snp.makeConstraints { make in
            make.top.equalTo(checklistNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(checklistNameLabel)
        }
        
        checklistNameEditButton.snp.makeConstraints { make in
            make.leading.equalTo(checklistNameLabel.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(-10)
            make.bottom.equalTo(checklistNameLabel.snp.bottom)
            make.size.equalTo(25)
        }
        
        bookmarkListButton.snp.makeConstraints { make in
            make.top.equalTo(checklistDateLabel.snp.bottom).offset(20)
            make.leading.equalTo(checklistDateLabel)
            make.width.equalTo(110)
            make.height.equalTo(35)
        }
        
        checklistDeleteButton.snp.makeConstraints { make in
            make.bottom.equalTo(bookmarkListButton.snp.bottom)
            make.trailing.equalToSuperview().inset(20)
        }
        
        checklistFixedButton.snp.makeConstraints { make in
            make.top.equalTo(checklistDeleteButton).offset(1)
            make.trailing.equalTo(checklistDeleteButton.snp.leading).offset(-8)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(bookmarkListButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        checklistCollectionView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(30)
            make.leading.equalTo(checklistNameLabel)
            make.trailing.equalToSuperview().inset(20)
        }
//        checklistCollectionView.backgroundColor = .lightGray
        
        plusButton.snp.makeConstraints { make in
            make.top.equalTo(checklistCollectionView.snp.bottom).offset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureChecklistCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 25
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
}
