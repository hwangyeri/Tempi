//
//  CategoryChecklistViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/04.
//

import UIKit
import RealmSwift

class CategoryChecklistViewController: BaseViewController {
        
    private let repository = ChecklistTableRepository()
    
    var categoryName: String?
    var subCategoryName: String?
    
    private var checkItemList: [String] {
        // subCategoryName, subCategoryName 일치하는 checkItem 필터링
        let checkItems = DataManager.shared.categoryList
            .filter { $0.categoryName == categoryName }
            .filter { $0.subCategoryName == subCategoryName }
            .map { $0.checkItem }
        
        let uniqueCheckItems = Array(Set(checkItems)) // 중복 제거
        return uniqueCheckItems
    }
    
    private var selectedIndexPaths: [IndexPath] = []
    private var selectedItems: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.mainView.selectedItemCountLabel.text = "category_checklist_itemCountLabel".localized(with: self.selectedItems.count)
            }
        }
    }
    
    private let mainView = CategoryChecklistView()
    
    private var categoryChecklistDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRightBarButton()
        hideBackButtonTitle()
        setLocalized()
        configureSubCategoryDataSource()
    }
    
    override func configureLayout() {
        mainView.categoryChecklistCollectionView.delegate = self
        mainView.selectAllCheckBox.addTarget(self, action: #selector(selectAllCheckBoxTapped), for: .touchUpInside)
        mainView.tButton.addTarget(self, action: #selector(addToMyListButtonTapped), for: .touchUpInside)
    }

    // MARK: - 초기 데이터 다국어 설정
    private func setLocalized() {
        guard let subCategoryName = subCategoryName else {
            return
        }
        
        DispatchQueue.main.async {
            self.mainView.checklistNameLabel.text = "category_checklist_checklistNameLabel".localized(with: subCategoryName)
            self.mainView.totalCountLabel.text = "category_checklist_totalCountLabel".localized(with: self.checkItemList.count)
            self.mainView.selectedItemCountLabel.text = "category_checklist_itemCountLabel".localized(with: self.selectedItems.count)
        }
    }
    
    // MARK: - 전체 선택/해제 버튼
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
                DispatchQueue.main.async {
                    cell.checkBoxButton.layer.backgroundColor = UIColor.label.cgColor
                    cell.checkBoxButton.setImage(UIImage(systemName: Constant.SFSymbol.checkIcon), for: .normal)
                    cell.tintColor = .systemBackground
                }
            }
        }
        
        // 나머지 항목은 선택 해제 상태로 설정
        for itemIndex in 0..<checkItemList.count {
            if !selectedIndexPaths.contains(IndexPath(item: itemIndex, section: 0)) {
                if let cell = mainView.categoryChecklistCollectionView.cellForItem(at: IndexPath(item: itemIndex, section: 0)) as? CategoryChecklistCollectionViewCell {
                    DispatchQueue.main.async {
                        cell.checkBoxButton.layer.backgroundColor = UIColor.systemBackground.cgColor
                        cell.checkBoxButton.setImage(nil, for: .normal)
                    }
                }
            }
        }
        
        // 전체 선택/해제 Button, Label UI 업데이트
        DispatchQueue.main.async {
            if self.mainView.selectAllCheckBox.isSelected {
                self.mainView.selectAllLabel.text = "category_checklist_selectAllLabel_unSelectAll".localized
                self.mainView.selectAllCheckBox.setImage(UIImage(systemName: Constant.SFSymbol.checkIcon), for: .normal)
                self.mainView.selectAllCheckBox.backgroundColor = .label
                self.mainView.selectAllCheckBox.tintColor = .systemBackground
                self.mainView.tButton.isEnabled = true
                self.mainView.tButton.backgroundColor = .label
            } else {
                self.mainView.selectAllLabel.text = "category_checklist_selectAllLabel_selectAll".localized
                self.mainView.selectAllCheckBox.setImage(nil, for: .normal)
                self.mainView.selectAllCheckBox.backgroundColor = .clear
                self.mainView.tButton.isEnabled = false
                self.mainView.tButton.backgroundColor = .tButtonDisable
            }
        }
    }
    
    // MARK: - 내 리스트에 추가하기 버튼
    @objc private func addToMyListButtonTapped() {
        print(#function)
        
        let addChecklistVC = AddChecklistViewController()
        
        addChecklistVC.subCategoryName = subCategoryName
        addChecklistVC.checkItemList = selectedItems
        
        repository.fetch { tasks in
            // addChecklistDataSource 에 쓰이는 데이터 미리 넘겨주기
            addChecklistVC.checklistTasks = tasks
        }
        
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
                cell.checkBoxButton.layer.backgroundColor = UIColor.systemBackground.cgColor
                cell.checkBoxButton.setImage(nil, for: .normal)
                
                if let itemIndex = selectedItems.firstIndex(of: selectedItem) {
                    selectedItems.remove(at: itemIndex)
                }
            } else {
                // 체크박스 선택 시, 배열에 추가 및 UI 업데이트
                selectedIndexPaths.append(indexPath)
                cell.checkBoxButton.layer.backgroundColor = UIColor.label.cgColor
                cell.checkBoxButton.setImage(UIImage(systemName: Constant.SFSymbol.checkIcon), for: .normal)
                cell.tintColor = .systemBackground
                
                selectedItems.append(selectedItem)
            }
        }
        
        // tButton 활성화/비활성화
        mainView.tButton.isEnabled = !selectedItems.isEmpty
        mainView.tButton.backgroundColor = selectedItems.isEmpty ? .tButtonDisable : .label
        //print(selectedItems, "-- 선택된 체크 아이템 --")
    }

}
