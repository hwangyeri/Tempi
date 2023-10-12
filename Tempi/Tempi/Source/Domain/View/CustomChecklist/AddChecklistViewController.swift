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
//        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
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
    
    @objc private func addToNewListButtonTapped() {
        print(#function)
        
        // FIXME: 선택 했을때 셀 전체 하이라이트 컬러? 적용됨
        
        mainView.addToNewListButton.isSelected = !mainView.addToNewListButton.isSelected
        
        if mainView.addToNewListButton.isSelected {
            mainView.addToNewListButton.layer.borderColor = UIColor.tGray1000.cgColor
        } else {
            mainView.addToNewListButton.layer.borderColor = UIColor.tGray400.cgColor
        }
        
    }
    
//    @objc private func cancelButtonTapped() {
//        print(#function)
//        self.dismiss(animated: true)
//    }
    
    @objc private func addButtonTapped() {
        print(#function)
        let ChecklistVC = ChecklistViewController()
        ChecklistVC.subCategoryName = subCategoryName
        ChecklistVC.checkItemList = checkItemList
        navigationController?.pushViewController(ChecklistVC, animated: true)
    }
    
}

// MARK: - CollectionView Delegate

extension AddChecklistViewController: UICollectionViewDelegate {
    
    // FIXME: 컬렉션 셀 클릭이 안됨...
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        if let cell = collectionView.cellForItem(at: indexPath) as? AddChecklistCollectionViewCell {
            cell.checklistButton.layer.borderColor = UIColor.tGray1000.cgColor
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function)
        if let cell = collectionView.cellForItem(at: indexPath) as? AddChecklistCollectionViewCell {
            cell.checklistButton.layer.borderColor = UIColor.tGray400.cgColor
        }
    }
    
}

