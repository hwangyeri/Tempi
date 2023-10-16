//
//  AddChecklistViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/11.
//

import UIKit
import RealmSwift

class AddChecklistViewController: BaseViewController {
        
    var checklistTasks: Results<ChecklistTable>!
    
    private let checklistRepository = ChecklistTableRepository()
    private let checkItemRepository = CheckItemTableRepository()
    
    var subCategoryName: String?
    var checkItemList: [String]?
    
    private var selectedIndex: IndexPath?
    
    private var isAnyButtonSelected: Bool = false {
        didSet {
            updateAddButtonState()
        }
    }
    
    let mainView = AddChecklistView()
    
    private var addChecklistDataSource: UICollectionViewDiffableDataSource<Int, ChecklistTable>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAddChecklistDataSource()
    }
    
    override func configureLayout() {
        mainView.addChecklistCollectionView.delegate = self
        mainView.addToNewListButton.addTarget(self, action: #selector(addToNewListButtonTapped), for: .touchUpInside)
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func updateAddButtonState() {
        print(#function)
        if isAnyButtonSelected {
            mainView.addButton.isEnabled = true
            mainView.addButton.backgroundColor = UIColor.tGray1000
        } else {
            mainView.addButton.isEnabled = false
            mainView.addButton.backgroundColor = UIColor.tGray400
        }
    }
    
    // MARK: 새로운 리스트에 추가하기 버튼
    @objc private func addToNewListButtonTapped() {
        print(#function)
        
        mainView.addToNewListButton.isSelected = true
        isAnyButtonSelected = true
        mainView.addToNewListButton.layer.borderColor = UIColor.tGray1000.cgColor
        mainView.addToNewListButton.layer.borderWidth = Constant.TChecklist.selectedBorderWidth
        
        if let selectedIndex = selectedIndex,
           let selectedCell = mainView.addChecklistCollectionView.cellForItem(at: selectedIndex) as? AddChecklistCollectionViewCell {
            selectedCell.checklistButton.layer.borderColor = UIColor.tGray400.cgColor
            selectedCell.checklistButton.layer.borderWidth = Constant.TChecklist.borderWidth
        }
        
        selectedIndex = nil
    }
    
    // MARK: 추가 버튼
    @objc private func addButtonTapped() {
        let checklistVC = ChecklistViewController()
        let selectedObjectId: ObjectId?
        
        if mainView.addToNewListButton.isSelected {
            // 새로운 리스트에 추가하기 버튼이 선택된 경우
            guard let subCategoryName = subCategoryName else {
                print(#function, "subCategoryName error")
                return
            }
            
            let newChecklist = ChecklistTable(checklistName: subCategoryName, createdAt: Date())
            checklistRepository.createItem(newChecklist)
            
            guard let newChecklistID = checklistRepository.getObjectIdForItem(newChecklist) else {
                print(#function, "newChecklistID error")
                return
            }
            
            selectedObjectId = newChecklistID
            
            guard let checkItemList = checkItemList else {
                print(#function, "checkItemList error")
                return
            }
    
            for item in checkItemList {
                let checkItemTask = CheckItemTable(checklistPK: newChecklistID, content: item, createdAt: Date(), memo: nil, alarmDate: nil, isChecked: false)
                checkItemRepository.createItem(checkItemTask)
            }
            
        } else {
            // 컬렉션 셀이 선택된 경우
            guard let selectedIndexPath = selectedIndex,
                  let selectedChecklist = addChecklistDataSource.itemIdentifier(for: selectedIndexPath) else {
                print("Error getting selected checklist")
                return
            }
            
            selectedObjectId = selectedChecklist.id
            
            guard let checkItemList = checkItemList else {
                print(#function, "checkItemList error")
                return
            }
            
            for item in checkItemList {
                let checkItemTask = CheckItemTable(checklistPK: selectedChecklist.id, content: item, createdAt: Date(), memo: nil, alarmDate: nil, isChecked: false)
                checkItemRepository.createItem(checkItemTask)
            }
        }
        
        guard let selectedObjectId = selectedObjectId else {
            print(#function, "selectedObjectId error")
            return
        }
        
        checklistVC.selectedChecklistID = selectedObjectId
        checkItemRepository.fetch(for: selectedObjectId) { task in
            checklistVC.checkItemTasks = task
        }

        navigationController?.pushViewController(checklistVC, animated: true)
    }
    
    // MARK: - CollectionView DataSource
    private func configureAddChecklistDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<AddChecklistCollectionViewCell, ChecklistTable> {
            cell, indexPath, itemIdentifier in
            cell.checklistButton.setTitle(itemIdentifier.checklistName, for: .normal)
        }
        
        addChecklistDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.addChecklistCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, ChecklistTable>()
        snapshot.appendSections([0])
        let result = Array(checklistTasks)
        snapshot.appendItems(result)
        addChecklistDataSource.apply(snapshot)
    }

}

// MARK: - CollectionView Delegate
extension AddChecklistViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        mainView.addToNewListButton.isSelected = false
        isAnyButtonSelected = false
        mainView.addToNewListButton.layer.borderColor = UIColor.tGray400.cgColor
        mainView.addToNewListButton.layer.borderWidth = Constant.TChecklist.borderWidth
        
        // 이전에 선택된 셀이 있는 경우, 선택 해제 및 UI 업데이트
        if let selectedIndex = selectedIndex,
           let selectedCell = collectionView.cellForItem(at: selectedIndex) as? AddChecklistCollectionViewCell {
            selectedCell.checklistButton.layer.borderColor = UIColor.tGray400.cgColor
            selectedCell.checklistButton.layer.borderWidth = Constant.TChecklist.borderWidth
        }
        
        // 현재 선택된 셀 UI 업데이트
        let selectedCell = collectionView.cellForItem(at: indexPath) as? AddChecklistCollectionViewCell
        selectedCell?.checklistButton.layer.borderColor = UIColor.tGray1000.cgColor
        selectedCell?.checklistButton.layer.borderWidth = Constant.TChecklist.selectedBorderWidth
        
        selectedIndex = indexPath
        isAnyButtonSelected = true
    }
    
}

