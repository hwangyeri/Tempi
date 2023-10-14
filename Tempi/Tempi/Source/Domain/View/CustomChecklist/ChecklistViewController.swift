//
//  ChecklistViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit

class ChecklistViewController: BaseViewController {
    
    var subCategoryName: String?
    var checkItemList: [String]?
    
    let mainView = ChecklistView()
    
    private var checklistDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureChecklistDataSource()
        setLocalized()
//        print("커스텀 체크리스트 서브카테고리: ", subCategoryName)
//        print("커스텀 체크리스트 체크아이템 리스트: ", checkItemList)
    }
    
    override func configureLayout() {
        mainView.checklistCollectionView.delegate = self
        mainView.exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        mainView.checklistNameEditButton.addTarget(self, action: #selector(checklistNameEditButtonTapped), for: .touchUpInside)
        mainView.checklistBookmarkButton.addTarget(self, action: #selector(checklistBookmarkButtonTapped), for: .touchUpInside)
        mainView.checklistDeleteButton.addTarget(self, action: #selector(checklistDeleteButtonTapped), for: .touchUpInside)
        mainView.bookmarkListButton.addTarget(self, action: #selector(bookmarkListButtonTapped), for: .touchUpInside)
    }
    
    private func setLocalized() {
        guard let subCategoryName = subCategoryName else {
            return
        }
        mainView.checklistNameLabel.text = "checklist_checklistNameLabel".localized(with: subCategoryName)
    }
    
    @objc private func exitButtonTapped() {
        print(#function)
        self.dismiss(animated: true)
    }
    
    @objc private func checklistNameEditButtonTapped() {
        print(#function)
    }
    
    @objc private func checklistBookmarkButtonTapped() {
        print(#function)
    }
    
    @objc private func checklistDeleteButtonTapped() {
        print(#function)
    }
    
    @objc private func bookmarkListButtonTapped() {
        print(#function)
        let bookmarkListVC = BookmarkListViewController()
        
        if let sheet = bookmarkListVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
        }
        
        self.present(bookmarkListVC, animated: true)
    }
    
    private func configureChecklistDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ChecklistCollectionViewCell, String> {
            cell, indexPath, itemIdentifier in
            
            cell.checkBoxLabel.text = itemIdentifier
            cell.checkBoxMemoLabel.text = itemIdentifier
            
            // Menu
            cell.checkBoxMenuButton.menu = UIMenu(preferredElementSize: .medium, children: [
                UIAction(title: "checklist_checkBoxMenuButton_firstMenu".localized, image: UIImage(systemName: Constant.SFSymbol.editMenuItemIcon), handler: { _ in
                    print("Edit Menu Tapped")
                }),
                UIAction(title: "checklist_checkBoxMenuButton_secondMenu".localized, image: UIImage(systemName: Constant.SFSymbol.addMemoMenuItemIcon), handler: { _ in
                    print("Add Memo Menu Tapped")
                }),
                UIAction(title: "checklist_checkBoxMenuButton_thirdMenu".localized, image: UIImage(systemName: Constant.SFSymbol.deleteMemuItemIcon), attributes: .destructive, handler: { _ in
                    print("Delete Menu Tapped")
                })
            ])
            
        }
        
        checklistDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.checklistCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        guard let checkItemList = checkItemList else {
            return
        }
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(checkItemList)
        checklistDataSource.apply(snapshot)
    }

}

// MARK: - CollectionView Delegate

extension ChecklistViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ChecklistCollectionViewCell {
            cell.checkBoxButton.layer.backgroundColor = UIColor.tGray1000.cgColor
            cell.checkBoxButton.setImage(UIImage(systemName: Constant.SFSymbol.checkIcon), for: .normal)
            cell.tintColor = .tGray100
        }
    }
    
}

// MARK: - Sheet Delegate

extension ChecklistViewController: UISheetPresentationControllerDelegate {
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        print(sheetPresentationController.selectedDetentIdentifier == .large ? "large" : "medium")
    }
    
}
