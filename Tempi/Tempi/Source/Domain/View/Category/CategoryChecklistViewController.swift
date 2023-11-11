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
        var uniqueCheckItems: [String] = []
        
        // categoryName 및 subCategoryName이 일치하는 항목(checkItem) 필터링 및 중복 확인
        for item in DataManager.shared.categoryList {
            if item.categoryName == categoryName, item.subCategoryName == subCategoryName, !uniqueCheckItems.contains(item.checkItem) {
                uniqueCheckItems.append(item.checkItem)
            }
        }
        
        return uniqueCheckItems
    }
    
    private var selectedItems: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                // 선택된 아이템 수
                self.mainView.selectedItemCountLabel.text = "category_checklist_itemCountLabel".localized(with: self.selectedItems.count)
            }
            // tButton 활성화/비활성화
            self.mainView.tButtonIsSelected = !self.selectedItems.isEmpty
            print(self.selectedItems, self.selectedItems.count)
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
        }
    }
    
    // MARK: - 전체 선택/해제 버튼
    @objc private func selectAllCheckBoxTapped() {
        if !mainView.selectAllCheckBox.isSelected {
            selectedItems = checkItemList
            self.mainView.tButtonIsSelected = true
            self.mainView.selectedAllCheckBoxIsSelected = true
            //print(mainView.selectAllCheckBox.isSelected)
        } else {
            selectedItems.removeAll()
            self.mainView.tButtonIsSelected = false
            self.mainView.selectedAllCheckBoxIsSelected = false
            //print(mainView.selectAllCheckBox.isSelected)
        }
        
        configureSubCategoryDataSource()
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

    // MARK: - CollectionView Delegate
    private func configureSubCategoryDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CategoryChecklistCollectionViewCell, String> {
            cell, indexPath, itemIdentifier in
            cell.checkBoxLabel.text = itemIdentifier
            cell.cellIsSelected = self.selectedItems.contains(itemIdentifier)
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
        guard let item = categoryChecklistDataSource.itemIdentifier(for: indexPath) else {
            // FIXME: Toast alert, Alert
            print("item Error")
            return
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryChecklistCollectionViewCell else {
            print("cell Error")
            return
        }
        
        cell.cellIsSelected.toggle()
        
        if cell.cellIsSelected {
            self.selectedItems.append(item)
        } else {
            if let index = self.selectedItems.firstIndex(of: item) {
                self.selectedItems.remove(at: index)
            }
        }
    }

}
