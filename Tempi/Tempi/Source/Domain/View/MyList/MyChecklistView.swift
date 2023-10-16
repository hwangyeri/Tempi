//
//  MyListView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import SnapKit

class MyChecklistView: BaseView {
    
    let mainLabel = {
       let view = TLabel(
        text: "myList_mainLabel".localized,
        custFont: .pretendardBoldXXXL,
        textColor: .tGray1000)
        let attrString = NSMutableAttributedString(string: "myList_mainLabel".localized)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        view.attributedText = attrString
        return view
    }()
    
    let plusButton = {
        let view = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 45, weight: .light)
        let image = UIImage(systemName: Constant.SFSymbol.plusCircleIcon, withConfiguration: imageConfig)
        view.setImage(image, for: .normal)
        view.tintColor = UIColor.tGray1000
        return view
    }()
    
    lazy var myListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureMyListCollectionLayout())

    override func configureHierarchy() {
        [mainLabel, plusButton, myListCollectionView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        mainLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        
        plusButton.snp.makeConstraints { make in
            make.bottom.equalTo(mainLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(40)
        }
        
        myListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        myListCollectionView.backgroundColor = .tGray200
    }
    
    private func configureMyListCollectionLayout() -> UICollectionViewLayout {
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
