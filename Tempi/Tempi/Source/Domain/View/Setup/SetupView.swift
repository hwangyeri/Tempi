//
//  SetupView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/23.
//

import UIKit
import SnapKit

final class SetupView: BaseView {
    
    let titleLabel = {
       let view = UILabel()
        return view
    }()
    
    lazy var setupCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureSetupCollectionLayout())
    
    override func configureHierarchy() {
        [titleLabel, setupCollectionView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            
        }
        
        setupCollectionView.snp.makeConstraints { make in
            
        }
    }
    
    private func configureSetupCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(75))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
}
