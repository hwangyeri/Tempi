//
//  BookmarkListView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/13.
//

import UIKit
import SnapKit

class BookmarkListView: BaseView {
    
    let infoImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: Constant.SFSymbol.infoIcon)
        view.tintColor = UIColor.tGray1000
        return view
    }()
    
    let mainLabel = {
       let view = TLabel(
        text: "bookmarkList_mainLabel".localized,
        custFont: .pretendardSemiBoldL,
        textColor: .tGray1000)
        return view
    }()
    
    let subLabel = {
        let view = TLabel(
         text: "bookmarkList_subLabel".localized,
         custFont: .pretendardRegularS,
         textColor: .tGray800)
         return view
    }()
    
    let selectedItemCountLabel = {
       let view = TLabel(
        text: "bookmarkList_selectedItemCountLabel".localized,
        custFont: .pretendardSemiBoldS,
        textColor: .tGray900)
        return view
    }()
    
    let totalCountLabel = {
       let view = TLabel(
        text: "10",
        custFont: .pretendardSemiBoldS,
        textColor: .tGray900)
        return view
    }()
    
    let selectAllLabel = {
       let view = TLabel(
        text: "bookmarkList_selectAllLabel_selectAll".localized,
        custFont: .pretendardRegularXS,
        textColor: .tGray1000)
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
    
    lazy var bookmarkListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureBookmarkListCollectionLayout())
    
    let addBookmarkButton = {
        let view = TImageButton(
            imageSize: Constant.TImageButton.bookmarkListImageSize,
            imageName: Constant.SFSymbol.plusIcon,
            imageColor: .tGray100
        )
        view.backgroundColor = UIColor.tGray1000
        view.layer.cornerRadius = Constant.TBlankCheckBox.cornerRadius
        return view
    }()
    
    let addBookmarkLabel = {
        let view = TLabel(
            text: "bookmarkList_addBookmarkLabel".localized,
            custFont: .pretendardRegularL,
            textColor: .tGray1000
        )
        return view
    }()
    
    let tButton = {
        let view = TButton(
            text: "bookmarkList_tButton".localized
        )
        return view
    }()
    
    override func configureHierarchy() {
        [infoImageView, mainLabel, subLabel, selectedItemCountLabel, totalCountLabel, selectAllCheckBox, selectAllLabel, divider, 
         bookmarkListCollectionView, addBookmarkButton, addBookmarkLabel, tButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        infoImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.size.equalTo(20)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infoImageView)
            make.leading.equalTo(infoImageView.snp.trailing).offset(8)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(infoImageView.snp.bottom).offset(10)
            make.leading.equalTo(infoImageView).inset(5)
        }
        
        selectedItemCountLabel.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(40)
            make.leading.equalTo(subLabel)
        }
        
        totalCountLabel.snp.makeConstraints { make in
            make.top.equalTo(selectedItemCountLabel)
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
            make.top.equalTo(selectedItemCountLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        bookmarkListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(25)
            make.leading.equalTo(selectedItemCountLabel)
            make.trailing.equalTo(selectAllCheckBox)
            make.height.equalTo(120)
//            make.bottom.equalTo(addBookmarkButton.snp.top)
        }
        bookmarkListCollectionView.backgroundColor = .point
        
        addBookmarkButton.snp.makeConstraints { make in
            make.top.equalTo(bookmarkListCollectionView.snp.bottom).offset(15)
            make.leading.equalTo(bookmarkListCollectionView)
            make.size.equalTo(30)
        }
        
        addBookmarkLabel.snp.makeConstraints { make in
            make.centerY.equalTo(addBookmarkButton)
            make.leading.equalTo(addBookmarkButton.snp.trailing).offset(12)
        }
        
        tButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(55)
        }
    }
    
    private func configureBookmarkListCollectionLayout() -> UICollectionViewLayout {
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
