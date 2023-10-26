//
//  BookmarkListView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/13.
//

import UIKit
import SnapKit

class BookmarkListView: BaseView {
    
    let emptyView = {
        let view = UIView()
        return view
    }()
    
    let emptySymbolLabel = {
        let view = UILabel()
        view.text = "📁"
        view.font = .systemFont(ofSize: 50)
        view.textAlignment = .center
        return view
    }()
    
    let emptyMainLabel = {
        let view = UILabel()
        view.text = "bookmarkList_emptyMainLabel".localized
        view.font = .customFont(.pretendardSemiBoldL)
        view.textColor = .label
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    let emptySubLabel = {
        let view = UILabel()
        view.setAttributedTextWithLineSpacing("bookmarkList_emptySubLabel".localized, lineSpacing: 5)
        view.font = .customFont(.pretendardRegularS)
        view.textColor = .label
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    let titleLabel = {
       let view = TLabel(
        text: "bookmarkList_titleLabel".localized,
        custFont: .pretendardSemiBoldM,
        textColor: .label)
        view.textAlignment = .center
        return view
    }()
    
    let mainLabel = {
       let view = TLabel(
        text: "bookmarkList_mainLabel".localized,
        custFont: .pretendardSemiBoldXL,
        textColor: .label)
        return view
    }()
    
    let subLabel = {
        let view = TLabel(
         text: "bookmarkList_subLabel".localized,
         custFont: .pretendardMediumS,
         textColor: .tGray900)
        view.setAttributedTextWithLineSpacing("bookmarkList_subLabel".localized, lineSpacing: 3)
         return view
    }()
    
    let selectAllLabel = {
       let view = TLabel(
        text: "bookmarkList_selectAllLabel_selectAll".localized,
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
    
    let addBookmarkItemLabel = {
        let view = TLabel(
            text: "bookmarkList_addBookmarkItemLabel".localized,
            custFont: .pretendardRegularXS,
            textColor: .label
        )
        return view
    }()
    
    let addBookmarkItemButton = {
        let view = UIButton()
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.tGray400.cgColor
        return view
    }()
    
    let selectedItemCountLabel = {
        let view = TLabel(
            text: "0",
            custFont: .pretendardMediumL,
            textColor: .label)
        return view
    }()
    
    let totalCountLabel = {
        let view = TLabel(
            text: "/10",
            custFont: .pretendardMediumL,
            textColor: .label)
        return view
    }()
    
    let plusImageButton = {
        let view = UIButton()
        view.isUserInteractionEnabled = false
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
        let image = UIImage(systemName: Constant.SFSymbol.plusIcon, withConfiguration: imageConfig)
        view.setImage(image, for: .normal)
        view.tintColor = .label
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var bookmarkListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureBookmarkListCollectionLayout())
    
    let tButton = {
        let view = TButton(
            text: "bookmarkList_tButton".localized
        )
        return view
    }()
    
    override func configureHierarchy() {
        [titleLabel, mainLabel, subLabel, selectAllLabel, selectAllCheckBox, divider, addBookmarkItemLabel, addBookmarkItemButton, bookmarkListCollectionView, tButton, emptyView].forEach {
            addSubview($0)
        }
        
        [selectedItemCountLabel, totalCountLabel, plusImageButton].forEach {
            addBookmarkItemButton.addSubview($0)
        }
        
        [emptySymbolLabel, emptyMainLabel, emptySubLabel].forEach {
            emptyView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(35)
            make.leading.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(10)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(mainLabel)
        }
        
        selectAllCheckBox.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(35)
            make.trailing.equalToSuperview().inset(25)
            make.size.equalTo(32)
        }
        
        selectAllLabel.snp.makeConstraints { make in
            make.centerY.equalTo(selectAllCheckBox)
            make.trailing.equalTo(selectAllCheckBox.snp.leading).offset(-8)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(selectAllCheckBox.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addBookmarkItemLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainLabel)
            make.centerY.equalTo(addBookmarkItemButton)
        }
        
        addBookmarkItemButton.snp.makeConstraints { make in
            make.leading.equalTo(addBookmarkItemLabel.snp.trailing).offset(8)
            make.top.equalTo(divider.snp.bottom).offset(20)
            make.height.equalTo(44)
        }
        
        selectedItemCountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        totalCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(selectedItemCountLabel.snp.trailing)
            make.centerY.equalToSuperview()
        }
        
        plusImageButton.snp.makeConstraints { make in
            make.leading.equalTo(totalCountLabel.snp.trailing).offset(13)
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        // FIXME: 컬렉션뷰 높이 유동적으로 변경될 수 있도록 수정하기
        bookmarkListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(addBookmarkItemButton.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.bottom.equalTo(tButton.snp.top).offset(-30)
        }
        
//        bookmarkListCollectionView.backgroundColor = .lightGray
        
        tButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(55)
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(bookmarkListCollectionView)
        }
        
        emptySymbolLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.horizontalEdges.equalToSuperview()
        }
        
        emptyMainLabel.snp.makeConstraints { make in
            make.top.equalTo(emptySymbolLabel.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        emptySubLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyMainLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(emptyMainLabel)
        }
    }
    
    private func configureBookmarkListCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}
