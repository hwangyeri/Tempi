//
//  AddChecklistViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/11.
//

import UIKit
import RealmSwift

class AddChecklistViewController: BaseViewController {
    
    let dummyList = ["일본 여행 소지품 체크리스트", "이마트 장보기", "check check", "롯데월드 체크리스트"]
    
    let realm = try! Realm()
    
    private var tasks: Results<ChecklistTable>!
    private let repository = ChecklistTableRepository()
    
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
//        print(realm.configuration.fileURL)
        
        repository.fetch { [weak self] tasks in
            guard let tasks = tasks else {
                print("Tasks is nil.")
                return
            }
            self?.tasks = tasks
            self?.configureAddChecklistDataSource()
        }
        
        print(tasks)
    }
    
    override func configureLayout() {
        mainView.addChecklistCollectionView.delegate = self
        mainView.addToNewListButton.addTarget(self, action: #selector(addToNewListButtonTapped), for: .touchUpInside)
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func configureAddChecklistDataSource() {
        guard let tasks = tasks else {
            // tasks 가 nil 인 경우, 핸들링 필요 ??
            print("tasks == nil 이면 실행되는 프린트")
            return
        }
        
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
        let result = Array(tasks)
        snapshot.appendItems(result)
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
        
        guard let subCategoryName = subCategoryName else {
            return
        }
        let task = ChecklistTable(checklistName: subCategoryName, createdAt: Date())
        repository.createItem(task)
        
        let checklistVC = ChecklistViewController()
        checklistVC.subCategoryName = subCategoryName
        checklistVC.checkItemList = checkItemList
//        checklistVC.modalPresentationStyle = .fullScreen
//        present(checklistVC, animated: true)
        navigationController?.pushViewController(checklistVC, animated: true)
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

