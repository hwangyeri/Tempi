//
//  AddChecklistViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/11.
//

import UIKit

class AddChecklistViewController: BaseViewController {
    
    let dummyList = ["일본 여행 소지품 체크리스트", "이마트 장보기", "check check", "롯데월드 체크리스트"]
    
    var subCategoryName: String?
    var checkItemList: [String]?
    
    private var selectedIndex: IndexPath?
    
    private var isAnyButtonSelected: Bool = false {
        didSet {
            updateAddButtonState()
        }
    }
    
    let mainView = AddChecklistView()
    
    private var addChecklistDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
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
    
    private func configureAddChecklistDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<AddChecklistCollectionViewCell, String> {
            cell, indexPath, itemIdentifier in
            cell.checklistButton.setTitle(itemIdentifier, for: .normal)
        }
        
        addChecklistDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.addChecklistCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(dummyList)
        addChecklistDataSource.apply(snapshot)
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
        print(#function)
        print(isAnyButtonSelected)
        let checklistVC = ChecklistViewController()
        checklistVC.subCategoryName = subCategoryName
        checklistVC.checkItemList = checkItemList
        checklistVC.modalPresentationStyle = .fullScreen
        present(checklistVC, animated: true)
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

