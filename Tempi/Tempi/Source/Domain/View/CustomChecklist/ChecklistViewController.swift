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
    
    private let mainView = ChecklistView()
    
    private var checklistDataSource: UICollectionViewDiffableDataSource<Int, CheckItemTable>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureChecklistDataSource()
        setChecklistData()
        setNavigationBarButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteChecklistNotificationObserver(notification:)), name: NSNotification.Name.deleteChecklist, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateChecklistNameNotificationObserver(notification:)), name: NSNotification.Name.updateChecklistName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteCheckItemNotificationObserver(notification:)), name: NSNotification.Name.deleteCheckItem, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func configureLayout() {
        mainView.checklistCollectionView.delegate = self
        mainView.checklistNameEditButton.addTarget(self, action: #selector(checklistNameEditButtonTapped), for: .touchUpInside)
        mainView.checklistFixedButton.addTarget(self, action: #selector(checklistFixedButtonTapped), for: .touchUpInside)
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
    
    // MARK: - 체크리스트 이름 수정 버튼
    @objc private func checklistNameEditButtonTapped() {
        print(#function)
        let editChecklistNameVC = EditChecklistNameViewController()
        editChecklistNameVC.modalTransitionStyle = .crossDissolve
        editChecklistNameVC.modalPresentationStyle = .overCurrentContext
        editChecklistNameVC.selectedChecklistID = selectedChecklistID
        editChecklistNameVC.textFieldPlaceholder = mainView.checklistNameLabel.text
        self.present(editChecklistNameVC, animated: true)
    }
    
    // MARK: - 체크리스트 고정 버튼
    @objc private func checklistFixedButtonTapped() {
        print(#function)
        
        guard let selectedChecklistID = selectedChecklistID else {
            print(#function, "selectedChecklistID error")
            return
        }
        
        guard let isFixed = checklistRepository.getIsFixed(forId: selectedChecklistID) else {
            return
        }
        
        DispatchQueue.main.async {
            if isFixed {
                let imageConfig = UIImage.SymbolConfiguration(pointSize: Constant.TImageButton.checklistImageSize, weight: .regular)
                let image = UIImage(systemName: Constant.SFSymbol.checklistUnFixedIcon, withConfiguration: imageConfig)
                self.mainView.checklistFixedButton.setImage(image, for: .normal)
                self.checklistRepository.updateIsFixed(forId: selectedChecklistID, isFixed: false)
            } else {
                let imageConfig = UIImage.SymbolConfiguration(pointSize: Constant.TImageButton.checklistImageSize, weight: .regular)
                let image = UIImage(systemName: Constant.SFSymbol.checklistFixedIcon, withConfiguration: imageConfig)
                self.mainView.checklistFixedButton.setImage(image, for: .normal)
                self.checklistRepository.updateIsFixed(forId: selectedChecklistID, isFixed: true)
            }
        }
    }
    
    // MARK: - 체크리스트 삭제 버튼
    @objc private func checklistDeleteButtonTapped() {
        print(#function)
        
        guard let selectedChecklistID = selectedChecklistID else {
            print(#function, "selectedChecklistID error")
            return
        }
        
        let popupVC = PopUpViewController()
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.selectedChecklistID = selectedChecklistID
        popupVC.popUpAction = .deleteChecklist
        self.present(popupVC, animated: true)
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
    
    // MARK: - 체크리스트 삭제 버튼 (노티)
    @objc func deleteChecklistNotificationObserver(notification: NSNotification) {
        print(#function)
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - 이름 수정 (노티)
    @objc func updateChecklistNameNotificationObserver(notification: NSNotification) {
        print(#function)
        
        DispatchQueue.main.async {
            if let newName = notification.userInfo?["checklistName"] as? String {
                self.mainView.checklistNameLabel.text = newName
            } else {
                print(#function, "newName error")
            }
        }
    }
    
    @objc func deleteCheckItemNotificationObserver(notification: NSNotification) {
        print(#function)
        
        // FIXME: 다국어 설정
        showToast(message: "성공적으로 삭제되었습니다!")
        
        // FIXME: 삭제된 CollectionViewCell 만 apply 해주기
        DispatchQueue.main.async {
            self.configureChecklistDataSource()
        }
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
                    
                    let checkItemID = itemIdentifier.id
                    
                    let popupVC = PopUpViewController()
                    popupVC.modalTransitionStyle = .crossDissolve
                    popupVC.modalPresentationStyle = .overCurrentContext
                    popupVC.selectedCheckItemID = checkItemID
                    popupVC.popUpAction = .deleteCheckItem
                    self.present(popupVC, animated: true)
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
        
        // FIXME: 체크박스 클릭시 Realm Data 상호작용 및 UI 업데이트 필요
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
