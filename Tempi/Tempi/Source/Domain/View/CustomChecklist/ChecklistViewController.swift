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
    private let bookmarkRepository = BookmarkTableRepository()
    
    private let mainView = ChecklistView()
    
    private var checklistDataSource: UICollectionViewDiffableDataSource<Int, CheckItemTable>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureChecklistDataSource()
        setChecklistData()
        setRightBarButton()
        setNotificationCenter()
    }
    
    override func configureLayout() {
        self.navigationItem.hidesBackButton = true
        mainView.checklistCollectionView.delegate = self
        mainView.checklistNameEditButton.addTarget(self, action: #selector(checklistNameEditButtonTapped), for: .touchUpInside)
        mainView.bookmarkListButton.addTarget(self, action: #selector(bookmarkListButtonTapped), for: .touchUpInside)
        mainView.checklistFixedButton.addTarget(self, action: #selector(checklistFixedButtonTapped), for: .touchUpInside)
        mainView.checklistDeleteButton.addTarget(self, action: #selector(checklistDeleteButtonTapped), for: .touchUpInside)
        mainView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 초기 데이터 설정
    private func setChecklistData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "checklist_checklistDateLabel".localized)
        
        guard let selectedChecklistID = selectedChecklistID else {
            print("No checklist is selected.")
            return
        }
        
        guard let checklistName = checklistRepository.getChecklistName(forId: selectedChecklistID) else {
            print("Checklist name is nil")
            return
        }
        
        guard let checklistDate = checklistRepository.getChecklistDate(forId: selectedChecklistID) else {
            print("Checklist date is nil")
            return
        }
        
        let dateString = dateFormatter.string(from: checklistDate)
        
        mainView.checklistNameLabel.text = checklistName
        mainView.checklistDateLabel.text = dateString
        
        guard let isFixed = checklistRepository.getIsFixed(forId: selectedChecklistID) else {
            print("isFixed Error")
            return
        }
        
        if isFixed {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: Constant.TImageButton.checklistImageSize, weight: .regular)
            let image = UIImage(systemName: Constant.SFSymbol.checklistFixedIcon, withConfiguration: imageConfig)
            self.mainView.checklistFixedButton.setImage(image, for: .normal)
        }
    }
    
    // MARK: - NotificationCenter 설정
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(deleteChecklistNotificationObserver(notification:)), name: .deleteChecklist, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateChecklistNameNotificationObserver(notification:)), name: .updateChecklistName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteCheckItemNotificationObserver(notification:)), name: .deleteCheckItem, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCheckItemContentNotificationObserver(notification:)), name: .updateCheckItemContent, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCheckItemMemoNotificationObserver(notification:)), name: .updateCheckItemMemo, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createCheckItemNotificationObserver(notification:)), name: .createCheckItem, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createChecklistNotificationObserver(notification:)), name: .createChecklistAlert, object: nil)
    }
    
    // MARK: - 체크리스트 이름 수정 버튼
    @objc private func checklistNameEditButtonTapped() {
        print(#function)
        let editChecklistNameVC = EditChecklistNameViewController()
        editChecklistNameVC.modalTransitionStyle = .crossDissolve
        editChecklistNameVC.modalPresentationStyle = .overCurrentContext
        editChecklistNameVC.selectedChecklistID = selectedChecklistID
        editChecklistNameVC.textFieldPlaceholder = mainView.checklistNameLabel.text
        editChecklistNameVC.nameAction = .updateChecklistName
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
            if isFixed { // True -> False
                let imageConfig = UIImage.SymbolConfiguration(pointSize: Constant.TImageButton.checklistImageSize, weight: .regular)
                let image = UIImage(systemName: Constant.SFSymbol.checklistUnFixedIcon, withConfiguration: imageConfig)
                self.mainView.checklistFixedButton.setImage(image, for: .normal)
                self.checklistRepository.updateIsFixed(forId: selectedChecklistID, newIsFixed: false)
            } else { // False -> True
                let imageConfig = UIImage.SymbolConfiguration(pointSize: Constant.TImageButton.checklistImageSize, weight: .regular)
                let image = UIImage(systemName: Constant.SFSymbol.checklistFixedIcon, withConfiguration: imageConfig)
                self.mainView.checklistFixedButton.setImage(image, for: .normal)
                self.checklistRepository.updateIsFixed(forId: selectedChecklistID, newIsFixed: true)
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
        
        let modalVC = DeleteModalViewController()
        modalVC.modalTransitionStyle = .crossDissolve
        modalVC.modalPresentationStyle = .overCurrentContext
        modalVC.selectedItemID = selectedChecklistID
        modalVC.deleteAction = .deleteChecklist
        self.present(modalVC, animated: true)
    }
    
    // MARK: - 즐겨찾기 버튼
    @objc private func bookmarkListButtonTapped() {
        print(#function)
        let bookmarkListVC = BookmarkListViewController()
        
        self.bookmarkRepository.fetch { data in
            bookmarkListVC.bookmarkTasks = data
        }
        
        if let sheet = bookmarkListVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.delegate = self
        }
        
        self.present(bookmarkListVC, animated: true)
    }
    
    // MARK: - 체크 항목 추가 버튼
    @objc private func plusButtonTapped() {
        print(#function)
        let editModalVC = EditModalViewController()
        editModalVC.modalTransitionStyle = .crossDissolve
        editModalVC.modalPresentationStyle = .overCurrentContext
        editModalVC.selectedItemID = selectedChecklistID
        editModalVC.textFieldPlaceholder = ""
        editModalVC.editAction = .createCheckItem
        self.present(editModalVC, animated: true)
    }
    
    // MARK: - 체크리스트 삭제 버튼 (노티)
    @objc func deleteChecklistNotificationObserver(notification: NSNotification) {
        print(#function)
        navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: .deleteChecklistAlert, object: nil)
    }
    
    // MARK: - 이름 수정 (노티)
    @objc func updateChecklistNameNotificationObserver(notification: NSNotification) {
        print(#function)
        
        guard let newName = notification.userInfo?["checklistName"] as? String else {
            print(#function, "newName error")
            return
        }
        
        DispatchQueue.main.async {
            self.mainView.checklistNameLabel.text = newName
        }
        
        showToast(message: "showToast_update".localized)
    }
    
    // MARK: - 체크아이템 삭제 apply (노티)
    @objc func deleteCheckItemNotificationObserver(notification: NSNotification) {
        print(#function)
        
        showToast(message: "showToast_delete".localized)
        
        DispatchQueue.main.async {
            self.configureChecklistDataSource()
        }
    }
    
    // MARK: - 체크아이템 내용 수정 apply (노티)
    @objc func updateCheckItemContentNotificationObserver(notification: NSNotification) {
        print(#function)
        
        showToast(message: "showToast_update".localized)
        
        DispatchQueue.main.async {
            self.configureChecklistDataSource()
        }
    }
    
    // MARK: - 체크아이템 메모 설정 apply (노티)
    @objc func updateCheckItemMemoNotificationObserver(notification: NSNotification) {
        print(#function)
        
        showToast(message: "showToast_update".localized)
        
        DispatchQueue.main.async {
            self.configureChecklistDataSource()
        }
    }
    
    // MARK: - 체크아이템 추가 apply (노티)
    @objc func createCheckItemNotificationObserver(notification: NSNotification) {
        print(#function)
        
        showToast(message: "showToast_create".localized)
        
        DispatchQueue.main.async {
            self.configureChecklistDataSource()
        }
    }
    
    // MARK: - 체크아이템 생성 시 Alert (노티)
    @objc func createChecklistNotificationObserver(notification: NSNotification) {
        print(#function)
        showMessage(title: "showMessage_create_title".localized, body: "showMessage_create_body".localized)
    }
    
    // MARK: - CollectionView DataSource
    private func configureChecklistDataSource() {
        print(#function)
        guard let checkItemTasks = checkItemTasks else {
            print("checkItemTasks is nil")
            return
        }
        
        let cellRegistration = UICollectionView.CellRegistration<ChecklistCollectionViewCell, CheckItemTable> {
            cell, indexPath, itemIdentifier in
            
            let checkItemID = itemIdentifier.id
            
            cell.checkBoxLabel.text = itemIdentifier.content
            cell.checkBoxMemoLabel.text = itemIdentifier.memo
            
            // MARK: - 체크아이템 메뉴 버튼
            cell.checkBoxMenuButton.menu = UIMenu(preferredElementSize: .medium, children: [
                /// 내용 수정
                UIAction(title: "checklist_checkBoxMenuButton_firstMenu".localized, image: UIImage(systemName: Constant.SFSymbol.editMenuItemIcon), handler: { _ in
                    print("Edit Menu Tapped")
                    
                    let editModalVC = EditModalViewController()
                    
                    editModalVC.modalTransitionStyle = .crossDissolve
                    editModalVC.modalPresentationStyle = .overCurrentContext
                    editModalVC.selectedItemID = checkItemID
                    editModalVC.editAction = .updateCheckItemContent
                    
                    let placeholder = self.checkItemRepository.getCheckItemContent(forId: checkItemID)
                    editModalVC.textFieldPlaceholder = placeholder
                    
                    self.present(editModalVC, animated: true)
                }),
                /// 메모 설정
                UIAction(title: "checklist_checkBoxMenuButton_secondMenu".localized, image: UIImage(systemName: Constant.SFSymbol.addMemoMenuItemIcon), handler: { _ in
                    print("Add Memo Menu Tapped")
                    
                    let editModalVC = EditModalViewController()
                    
                    editModalVC.modalTransitionStyle = .crossDissolve
                    editModalVC.modalPresentationStyle = .overCurrentContext
                    editModalVC.selectedItemID = checkItemID
                    editModalVC.editAction = .updateCheckItemMemo
                    
                    let placeholder = self.checkItemRepository.getCheckItemMemo(forId: checkItemID) ?? ""
                    editModalVC.textFieldPlaceholder = placeholder
                    
                    self.present(editModalVC, animated: true)
                }),
                /// 삭제
                UIAction(title: "checklist_checkBoxMenuButton_thirdMenu".localized, image: UIImage(systemName: Constant.SFSymbol.deleteMemuItemIcon), attributes: .destructive, handler: { _ in
                    print("Delete Menu Tapped")
                    
                    let modalVC = DeleteModalViewController()
                    
                    modalVC.modalTransitionStyle = .crossDissolve
                    modalVC.modalPresentationStyle = .overCurrentContext
                    modalVC.selectedItemID = checkItemID
                    modalVC.deleteAction = .deleteCheckItem
                    
                    self.present(modalVC, animated: true)
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
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .deleteChecklist, object: nil)
        NotificationCenter.default.removeObserver(self, name: .updateChecklistName, object: nil)
        NotificationCenter.default.removeObserver(self, name: .deleteCheckItem, object: nil)
        NotificationCenter.default.removeObserver(self, name: .updateCheckItemContent, object: nil)
        NotificationCenter.default.removeObserver(self, name: .updateCheckItemMemo, object: nil)
        NotificationCenter.default.removeObserver(self, name: .createCheckItem, object: nil)
        NotificationCenter.default.removeObserver(self, name: .createChecklistAlert, object: nil)
    }
    
}

// MARK: - CollectionView Delegate
extension ChecklistViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        guard let selectedItem = checklistDataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        let isCheckedOfSelectedCell = checkItemRepository.getCheckItemIsChecked(forId: selectedItem.id)
        
        guard let isChecked = isCheckedOfSelectedCell else {
            print("isChecked error")
            return
        }
        
        // FIXME: cellForItem -> UICollectionViewDiffableDataSource 안에서 구현하는 걸로 변경?
        if let cell = collectionView.cellForItem(at: indexPath) as? ChecklistCollectionViewCell {
            if !isChecked {
                // False -> True
                DispatchQueue.main.async {
                    cell.checkBoxButton.layer.backgroundColor = UIColor.label.cgColor
                    cell.checkBoxButton.setImage(UIImage(systemName: Constant.SFSymbol.checkIcon), for: .normal)
                    cell.tintColor = .systemBackground
                }
                checkItemRepository.updateCheckItemIsChecked(forId: selectedItem.id, newIsChecked: true)
            } else {
                // True -> False
                DispatchQueue.main.async {
                    cell.checkBoxButton.layer.backgroundColor = UIColor.systemBackground.cgColor
                    cell.checkBoxButton.setImage(nil, for: .normal)
                }
                checkItemRepository.updateCheckItemIsChecked(forId: selectedItem.id, newIsChecked: false)
            }
        }
    }
    
}


// MARK: - Sheet Delegate
extension ChecklistViewController: UISheetPresentationControllerDelegate {
    
}
