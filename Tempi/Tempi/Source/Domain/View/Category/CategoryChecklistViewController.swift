//
//  CategoryChecklistViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/04.
//

import UIKit

class CategoryChecklistViewController: BaseViewController {
    
    var categoryName: String?
    var subCategoryName: String?
    
    private var checkItemList: [String] {
        // subCategoryName, subCategoryName 일치하는 checkItem 필터링
        return DataManager.shared.categoryList
            .filter { $0.categoryName == categoryName }
            .filter { $0.subCategoryName == subCategoryName }
            .map { $0.checkItem }
    }
    
    private var selectedIndexPaths: [IndexPath] = []
    
    let mainView = CategoryChecklistView()
    
    private var categoryChecklistDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubCategoryDataSource()
        
//        print("--- checklist ", categoryName)
//        print("--- checklist ", subCategoryName)
    }
    
    override func configureHierarchy() {
        mainView.categoryChecklistCollectionView.delegate = self
        mainView.selectAllCheckBox.addTarget(self, action: #selector(selectAllCheckBoxTapped), for: .touchUpInside)
        mainView.tButton.addTarget(self, action: #selector(AddToMyListButtonTapped), for: .touchUpInside)
    }
    
    @objc private func selectAllCheckBoxTapped() {
        if mainView.selectAllCheckBox.isSelected {
            // 전체 해제
            selectedIndexPaths.removeAll()
            mainView.selectAllCheckBox.isSelected = false
        } else {
            // 전체 선택
            selectedIndexPaths = (0..<checkItemList.count).map { IndexPath(item: $0, section: 0) }
            mainView.selectAllCheckBox.isSelected = true
        }
       
        // 선택된 항목만 선택된 상태로 설정
        for indexPath in selectedIndexPaths {
            if let cell = mainView.categoryChecklistCollectionView.cellForItem(at: indexPath) as? CategoryChecklistCollectionViewCell {
                cell.checkBoxButton.layer.backgroundColor = UIColor.tGray1000.cgColor
                cell.checkBoxButton.setImage(UIImage(systemName: Constant.SFSymbol.checkIcon), for: .normal)
                cell.tintColor = .tGray100
            }
        }
        
        // 나머지 항목은 선택 해제 상태로 설정
        for itemIndex in 0..<checkItemList.count {
            if !selectedIndexPaths.contains(IndexPath(item: itemIndex, section: 0)) {
                if let cell = mainView.categoryChecklistCollectionView.cellForItem(at: IndexPath(item: itemIndex, section: 0)) as? CategoryChecklistCollectionViewCell {
                    cell.checkBoxButton.layer.backgroundColor = UIColor.tGray100.cgColor
                    cell.checkBoxButton.setImage(nil, for: .normal)
                    cell.tintColor = .clear
                }
            }
        }
        
        // 전체 선택/해제 Button, Label UI 업데이트
        if mainView.selectAllCheckBox.isSelected {
            // FIXME: 전체 해제 - 다국어 설정
            mainView.selectAllLabel.text = "전체 해제"
            mainView.selectAllCheckBox.setImage(UIImage(systemName: Constant.SFSymbol.checkIcon), for: .normal)
            mainView.selectAllCheckBox.backgroundColor = .tGray1000
            mainView.selectAllCheckBox.tintColor = .tGray100
            mainView.tButton.isEnabled = true
            mainView.tButton.backgroundColor = .tGray1000
        } else {
            mainView.selectAllLabel.text = "category_checklist_select_all_label".localized
            mainView.selectAllCheckBox.setImage(nil, for: .normal)
            mainView.selectAllCheckBox.backgroundColor = .clear
            mainView.tButton.isEnabled = false
            mainView.tButton.backgroundColor = .tGray200
        }
    
    }
    
    @objc private func AddToMyListButtonTapped() {
        print(#function)
        let ChecklistVC = ChecklistViewController()
        navigationController?.pushViewController(ChecklistVC, animated: true)
    }

    private func configureSubCategoryDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CategoryChecklistCollectionViewCell, String> {
            cell, indexPath, itemIdentifier in
            cell.checkBoxLabel.text = itemIdentifier
//            cell.backgroundColor = .red
        }
        
        categoryChecklistDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.categoryChecklistCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(checkItemList)
        categoryChecklistDataSource.apply(snapshot)
    }
    
}

// MARK: - CollectionView Delegate

extension CategoryChecklistViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryChecklistCollectionViewCell {
            if let selectedIndex = selectedIndexPaths.firstIndex(of: indexPath) {
                // 체크박스 선택 해제시, 배열에서 삭제 및 UI 업데이트
                selectedIndexPaths.remove(at: selectedIndex)
                cell.checkBoxButton.layer.backgroundColor = UIColor.tGray100.cgColor
                cell.checkBoxButton.setImage(nil, for: .normal)
            } else {
                // 체크박스 선택 시, 배열에 추가 및 UI 업데이트
                selectedIndexPaths.append(indexPath)
                cell.checkBoxButton.layer.backgroundColor = UIColor.tGray1000.cgColor
                cell.checkBoxButton.setImage(UIImage(systemName: Constant.SFSymbol.checkIcon), for: .normal)
                cell.tintColor = .tGray100
            }
        }
        
        // tButton Disable 처리
        if selectedIndexPaths.isEmpty {
            mainView.tButton.isEnabled = false
            mainView.tButton.backgroundColor = .tGray200
            print(selectedIndexPaths, "-- cell --")
        } else {
            mainView.tButton.isEnabled = true
            mainView.tButton.backgroundColor = .tGray1000
            print(selectedIndexPaths, "-- cell --")

        }
    }

}
