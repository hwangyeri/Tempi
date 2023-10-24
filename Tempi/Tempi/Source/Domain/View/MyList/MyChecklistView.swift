//
//  MyListView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import SnapKit

class MyChecklistView: BaseView {
    
    let emptyView = {
        let view = UIView()
        return view
    }()
    
    let emptySymbolLabel = {
        let view = UILabel()
        view.text = "📁"
        view.font = .systemFont(ofSize: 50)
        return view
    }()
    
    let emptyMainLabel = {
        let view = UILabel()
        view.text = "myList_emptyMainLabel".localized
        view.font = .customFont(.pretendardSemiBoldL)
        view.textColor = .label
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    let emptySubLabel = {
        let view = UILabel()
        let attrString = NSMutableAttributedString(string: "myList_emptySubLabel".localized)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        view.attributedText = attrString
        view.font = .customFont(.pretendardRegularS)
        view.textColor = .label
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
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
        [mainLabel, plusButton, myListCollectionView, emptyView].forEach {
            addSubview($0)
        }
        
        [emptySymbolLabel, emptyMainLabel, emptySubLabel].forEach {
            emptyView.addSubview($0)
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
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(myListCollectionView)
        }
        
        emptySymbolLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-90)
            make.centerX.equalToSuperview()
        }
        
        emptyMainLabel.snp.makeConstraints { make in
            make.top.equalTo(emptySymbolLabel.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        emptySubLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyMainLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(emptyMainLabel)
        }
    }
    
    private func configureMyListCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(75))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 10
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}
