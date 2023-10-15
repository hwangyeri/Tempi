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
//    private var selectedItems: [String] = []
    private var selectedItems: [String] = [] {
        didSet {
            mainView.selectedItemCountLabel.text = "category_checklist_itemCountLabel".localized(with: selectedItems.count)
        }
    }
    
    let mainView = CategoryChecklistView()
    
    private var categoryChecklistDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubCategoryDataSource()
        setLocalized()
        
//        print("--- checklist ", categoryName)
//        print("--- checklist ", subCategoryName)
    }
    
    override func configureLayout() {
        mainView.categoryChecklistCollectionView.delegate = self
        mainView.selectAllCheckBox.addTarget(self, action: #selector(selectAllCheckBoxTapped), for: .touchUpInside)
        mainView.tButton.addTarget(self, action: #selector(addToMyListButtonTapped), for: .touchUpInside)
    }

    private func setLocalized() {
        guard let subCategoryName = subCategoryName else {
            return
        }
        mainView.checklistNameLabel.text = "category_checklist_checklistNameLabel".localized(with: subCategoryName)
        mainView.totalCountLabel.text = "category_checklist_totalCountLabel".localized(with: checkItemList.count)
        mainView.selectedItemCountLabel.text = "category_checklist_itemCountLabel".localized(with: selectedItems.count)
    }
    
    @objc private func selectAllCheckBoxTapped() {
        if mainView.selectAllCheckBox.isSelected {
            // 전체 해제
            selectedIndexPaths.removeAll()
            selectedItems.removeAll()
            print(selectedItems, "-- 선택된 체크 아이템 --")
            mainView.selectAllCheckBox.isSelected = false
        } else {
            // 전체 선택
            selectedIndexPaths = (0..<checkItemList.count).map { IndexPath(item: $0, section: 0) }
            selectedItems = checkItemList
            print(selectedItems, "-- 선택된 체크 아이템 --")
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
                }
            }
        }
        
        // 전체 선택/해제 Button, Label UI 업데이트
        if mainView.selectAllCheckBox.isSelected {
            mainView.selectAllLabel.text = "category_checklist_selectAllLabel_unSelectAll".localized
            mainView.selectAllCheckBox.setImage(UIImage(systemName: Constant.SFSymbol.checkIcon), for: .normal)
            mainView.selectAllCheckBox.backgroundColor = .tGray1000
            mainView.selectAllCheckBox.tintColor = .tGray100
            mainView.tButton.isEnabled = true
            mainView.tButton.backgroundColor = .tGray1000
        } else {
            mainView.selectAllLabel.text = "category_checklist_selectAllLabel_selectAll".localized
            mainView.selectAllCheckBox.setImage(nil, for: .normal)
            mainView.selectAllCheckBox.backgroundColor = .clear
            mainView.tButton.isEnabled = false
            mainView.tButton.backgroundColor = .tGray200
        }
    
    }
    
    // MARK: - 내 리스트에 추가하기 버튼
    
    @objc private func addToMyListButtonTapped() {
        print(#function)
        
        let addChecklistVC = AddChecklistViewController()
        addChecklistVC.subCategoryName = subCategoryName
        addChecklistVC.checkItemList = selectedItems
        
//        if let sheet = addChecklistVC.sheetPresentationController {
//            // sheet size 지정
//            sheet.detents = [.medium(), .large()]
//            // sheet size 변화 감지
//            sheet.delegate = self
//            // sheet 상단에 그래버 표시 (기본 값 false)
//            sheet.prefersGrabberVisible = true
//        }
//        
//        self.present(addChecklistVC, animated: true)
        navigationController?.pushViewController(addChecklistVC, animated: true)
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
            
            guard let selectedItem = categoryChecklistDataSource.itemIdentifier(for: indexPath) else {
                // FIXME: Toast alert, Alert 및 예외 처리
                return
            }
            
            if let selectedIndex = selectedIndexPaths.firstIndex(of: indexPath) {
                // 체크박스 선택 해제시, 배열에서 삭제 및 UI 업데이트
                selectedIndexPaths.remove(at: selectedIndex)
                cell.checkBoxButton.layer.backgroundColor = UIColor.tGray100.cgColor
                cell.checkBoxButton.setImage(nil, for: .normal)
                
                if let itemIndex = selectedItems.firstIndex(of: selectedItem) {
                    selectedItems.remove(at: itemIndex)
                }
            } else {
                // 체크박스 선택 시, 배열에 추가 및 UI 업데이트
                selectedIndexPaths.append(indexPath)
                cell.checkBoxButton.layer.backgroundColor = UIColor.tGray1000.cgColor
                cell.checkBoxButton.setImage(UIImage(systemName: Constant.SFSymbol.checkIcon), for: .normal)
                cell.tintColor = .tGray100
                
                selectedItems.append(selectedItem)
            }
        }
        
        // tButton 활성화/비활성화
        mainView.tButton.isEnabled = !selectedItems.isEmpty
        mainView.tButton.backgroundColor = selectedItems.isEmpty ? .tGray200 : .tGray1000
        print(selectedItems, "-- 선택된 체크 아이템 --")
    }

}

// MARK: - SheetPresentation Delegate

extension CategoryChecklistViewController: UISheetPresentationControllerDelegate {
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        print(sheetPresentationController.selectedDetentIdentifier == .large ? "large" : "medium")
    }
    
}
