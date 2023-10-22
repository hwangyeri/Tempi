//
//  CategoryHomeView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import UIKit
import SnapKit

class CategoryHomeView: BaseView {
    
    let backView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainBack
        return view
    }()
    
    let searchMainLabel = {
       let view = TLabel(
        text: "search_main_label".localized,
        custFont: .pretendardBoldXL,
        textColor: .white)
        let attrString = NSMutableAttributedString(string: "search_main_label".localized)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        view.attributedText = attrString
        return view
    }()
    
    let searchBackgroundButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.tGray900
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.tGray800.cgColor
        return view
    }()
    
    let searchLabel = {
        let view = TLabel(
            text: "searchBar_placeholder".localized,
            custFont: .pretendardRegularS,
            textColor: .tGray700
        )
        return view
    }()
    
    let searchImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "magnifyingglass.circle.fill")
        view.contentMode = .scaleAspectFit
        view.tintColor = UIColor.point
        return view
    }()
    
    let categoryDivider = {
        let view = UIView()
        view.backgroundColor = UIColor.tGray1000
        return view
    }()
    
    let categoryTitleLabel = {
        let view = TLabel(
            text: "category_title_label".localized,
            custFont: .pretendardBlackXL,
            textColor: .tGray1000)
        return view
    }()
 
    let categoryMainLabel = {
        let view = TLabel(
            text: "category_main_label".localized,
            custFont: .pretendardBoldL,
            textColor: .tGray1000)
        return view
    }()
    
    let categorySubLabel = {
        let view = TLabel(
            text: "category_sub_label".localized,
            custFont: .pretendardRegularXS,
            textColor: .tGray800)
        view.textAlignment = .center
        return view
    }()
    
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCategoryCollectionLayout())
    
    let plusButton = {
        let view = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
        let image = UIImage(systemName: Constant.SFSymbol.plusCircleIcon, withConfiguration: imageConfig)
        view.setImage(image, for: .normal)
        view.tintColor = UIColor.tGray1000
        return view
    }()
    
    override func configureHierarchy() {
        [backView, categoryDivider, categoryTitleLabel, categoryMainLabel, categorySubLabel, categoryCollectionView, plusButton].forEach {
            addSubview($0)
        }
        
        [searchMainLabel, searchBackgroundButton].forEach {
            backView.addSubview($0)
        }
        
        [searchLabel, searchImageView].forEach {
            searchBackgroundButton.addSubview($0)
        }
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self)
        }
        
        searchMainLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(20)
        }
        
        searchBackgroundButton.snp.makeConstraints { make in
            make.top.equalTo(searchMainLabel.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
            make.bottom.equalToSuperview().inset(30)
        }
        
        searchLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
            make.size.equalTo(30)
        }
        
        categoryDivider.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(3)
            make.height.equalTo(categoryTitleLabel)
        }
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryDivider)
            make.leading.equalTo(categoryDivider).offset(10)
        }
        
        categoryMainLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleLabel.snp.bottom).offset(30)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        categorySubLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryMainLabel.snp.bottom).offset(8)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categorySubLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
//        categoryCollectionView.backgroundColor = .lightGray
        
        plusButton.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(25)
        }
    }
    
    private func configureCategoryCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 30
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
}
