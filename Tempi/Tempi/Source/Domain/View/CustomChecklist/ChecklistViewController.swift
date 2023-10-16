//
//  ChecklistViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit
import RealmSwift

class ChecklistViewController: BaseViewController {
    
    var selectedChecklistID: ObjectId?
    var checkItemTasks: Results<CheckItemTable>!
    
    private let checklistRepository = ChecklistTableRepository()
    private let checkItemRepository = CheckItemTableRepository()
    
    
    let mainView = ChecklistView()
    
    private var checklistDataSource: UICollectionViewDiffableDataSource<Int, CheckItemTable>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureChecklistDataSource()
        setChecklistData()
        setNavigationBarButton()
    }
    
    override func configureLayout() {
        mainView.checklistCollectionView.delegate = self
        mainView.checklistNameEditButton.addTarget(self, action: #selector(checklistNameEditButtonTapped), for: .touchUpInside)
        mainView.checklistBookmarkButton.addTarget(self, action: #selector(checklistBookmarkButtonTapped), for: .touchUpInside)
        mainView.checklistDeleteButton.addTarget(self, action: #selector(checklistDeleteButtonTapped), for: .touchUpInside)
        mainView.bookmarkListButton.addTarget(self, action: #selector(bookmarkListButtonTapped), for: .touchUpInside)
    }
    
    private func setChecklistData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "checklist_checklistDateLabel".localized)
        
        guard let selectedChecklistID = selectedChecklistID else {
            return
        }
        let checklistName = checklistRepository.getChecklistName(forId: selectedChecklistID)
        
        guard let checklistDate = checklistRepository.getChecklistDate(forId: selectedChecklistID) else {
            return
        }
        let dateString = dateFormatter.string(from: checklistDate)
        
        mainView.checklistNameLabel.text = checklistName
        mainView.checklistDateLabel.text = dateString
    }
    
    private func setNavigationBarButton() {
        let barButtonIcon = UIImage(systemName: Constant.SFSymbol.xmarkIcon)
        let rightBarButton = UIBarButtonItem(image: barButtonIcon, style: .plain, target: self, action: #selector(rightBarButtonTapped))
        rightBarButton.tintColor = .tGray1000
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - 오른쪽 네비 바 버튼
    @objc private func rightBarButtonTapped() {
        print(#function)
        navigationController?.popToRootViewController(animated: true)
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
    
    // MARK: - 즐겨찾기 버튼
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
    
    // MARK: - CollectionView DataSource
    private func configureChecklistDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ChecklistCollectionViewCell, CheckItemTable> {
            cell, indexPath, itemIdentifier in
            
            cell.checkBoxLabel.text = itemIdentifier.content
            cell.checkBoxMemoLabel.text = itemIdentifier.memo
            
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
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, CheckItemTable>()
        snapshot.appendSections([0])
        let result = Array(checkItemTasks)
        snapshot.appendItems(result)
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
