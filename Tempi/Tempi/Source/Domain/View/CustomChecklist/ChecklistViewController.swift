//
//  ChecklistViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/05.
//

import UIKit
import RealmSwift

final class ChecklistViewController: BaseViewController {
    
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
        isCreated()
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
    
    //MARK: - 초기 데이터 설정
    private func setChecklistData() {
        print(#function)
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
        
        mainView.checklistFixedButton.isSelected = isFixed
    }
    
    //MARK: - NotificationCenter 설정
    private func setNotificationCenter() {
        print(#function)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteChecklistNotificationObserver), name: .deleteChecklist, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateChecklistNameNotificationObserver), name: .updateChecklistName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteCheckItemNotificationObserver), name: .deleteCheckItem, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCheckItemContentNotificationObserver), name: .updateCheckItemContent, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCheckItemMemoNotificationObserver), name: .updateCheckItemMemo, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createCheckItemNotificationObserver), name: .createCheckItem, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateChecklistFixedButtonNotificationObserver), name: .updateChecklistFixedButton, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCheckBoxStateAlertNotificationObserver), name: .updateCheckBoxStateAlert, object: nil)
    }
    
    //MARK: - 체크리스트 생성 상태 확인 메서드
    private func isCreated() {
        print(#function)
        
        let isCreatedValue = UserDefaults.standard.bool(forKey: "isCreated")
        
        if isCreatedValue {
            // 새롭게 생성한 체크리스트인 경우 showMessage
            showMessage(title: "showMessage_create_title".localized, body: "showMessage_create_body".localized)
            UserDefaults.standard.isCreated = false
        } else {
            print("Value is false")
        }
    }
    
    //MARK: - 체크리스트 이름 수정 버튼
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
    
    //MARK: - 체크리스트 고정 버튼
    @objc private func checklistFixedButtonTapped() {
        print(#function)
        
        guard let selectedChecklistID = selectedChecklistID else {
            print(#function, "selectedChecklistID error")
            return
        }
        
        guard let isFixed = checklistRepository.getIsFixed(forId: selectedChecklistID) else {
            return
        }
        
        let newIsFixed = !isFixed
        self.checklistRepository.updateIsFixed(forId: selectedChecklistID, newIsFixed: newIsFixed)
        
        NotificationCenter.default.post(name: .updateChecklistFixedButton, object: nil, userInfo: ["newIsFixed": newIsFixed])
    }
    
    //MARK: - 체크리스트 고정 버튼 (노티)
    @objc func updateChecklistFixedButtonNotificationObserver(_ notification: NSNotification) {
        print(#function)

        guard let newIsFixed = notification.userInfo?["newIsFixed"] as? Bool else {
            print(#function, "newIsFixed error")
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.mainView.checklistFixedButton.isSelected.toggle()

            if !newIsFixed {
                print("a", newIsFixed)
                self?.showToast(message: "showToast_updateFixButton_unfixed".localized)
            } else {
                print("b", newIsFixed)
                self?.showToast(message: "showToast_updateFixButton_fixed".localized)
            }
        }
    }
    
    //MARK: - 체크리스트 삭제 버튼
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
    
    //MARK: - 즐겨찾기 버튼
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

        bookmarkListVC.selectedChecklistID = self.selectedChecklistID
        
        self.present(bookmarkListVC, animated: true)
    }
    
    //MARK: - 체크 항목 추가 버튼
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
    
    //MARK: - 체크박스 체크 시 알럿 (노티)
    @objc func updateCheckBoxStateAlertNotificationObserver(_ notification: NSNotification) {
        print(#function)
        showToast(message: "showToast_checkbox_isSelected".localized)
    }
    
    //MARK: - 체크리스트 삭제 버튼 (노티)
    @objc func deleteChecklistNotificationObserver(_ notification: NSNotification) {
        print(#function)
        navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: .deleteChecklistAlert, object: nil)
    }
    
    //MARK: - 이름 수정 (노티)
    @objc func updateChecklistNameNotificationObserver(_ notification: NSNotification) {
        print(#function)
        
        guard let newName = notification.userInfo?["checklistName"] as? String else {
            print(#function, "newName error")
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.mainView.checklistNameLabel.text = newName
        }
        
        showToast(message: "showToast_update".localized)
    }
    
    //MARK: - 체크아이템 삭제 apply (노티)
    @objc func deleteCheckItemNotificationObserver(_ notification: NSNotification) {
        print(#function)
        
        showToast(message: "showToast_delete".localized)
        
        DispatchQueue.main.async { [weak self] in
            self?.configureChecklistDataSource()
        }
    }
    
    //MARK: - 체크아이템 내용 수정 apply (노티)
    @objc func updateCheckItemContentNotificationObserver(_ notification: NSNotification) {
        print(#function)
        
        showToast(message: "showToast_update".localized)
        
        DispatchQueue.main.async { [weak self] in
            self?.configureChecklistDataSource()
        }
    }
    
    //MARK: - 체크아이템 메모 설정 apply (노티)
    @objc func updateCheckItemMemoNotificationObserver(_ notification: NSNotification) {
        print(#function)
        
        showToast(message: "showToast_update".localized)
        
        DispatchQueue.main.async { [weak self] in
            self?.configureChecklistDataSource()
        }
    }
    
    //MARK: - 체크아이템 추가 apply (노티)
    @objc func createCheckItemNotificationObserver(_ notification: NSNotification) {
        print(#function)
        
        showToast(message: "showToast_create".localized)
        
        DispatchQueue.main.async { [weak self] in
            self?.configureChecklistDataSource()
        }
    }
    
    //MARK: - CollectionView DataSource
    private func configureChecklistDataSource() {
        print(#function)
        guard let checkItemTasks = checkItemTasks else {
            print("checkItemTasks is nil")
            return
        }
        
        let cellRegistration = UICollectionView.CellRegistration<ChecklistCollectionViewCell, CheckItemTable> {
            [weak self] cell, indexPath, itemIdentifier in
            
            let checkItemID = itemIdentifier.id
            
            cell.checkBoxLabel.text = itemIdentifier.content
            cell.checkBoxMemoLabel.text = itemIdentifier.memo
            cell.cellIsSelected = itemIdentifier.isChecked
            
            /// 체크아이템 메뉴 버튼
            cell.checkBoxMenuButton.menu = UIMenu(preferredElementSize: .medium, children: [
                
                // 내용 수정
                UIAction(title: "checklist_checkBoxMenuButton_firstMenu".localized, image: UIImage(systemName: Constant.SFSymbol.editMenuItemIcon), handler: { _ in
                    print("Edit Menu Tapped")
                    
                    let editModalVC = EditModalViewController()
                    
                    editModalVC.modalTransitionStyle = .crossDissolve
                    editModalVC.modalPresentationStyle = .overCurrentContext
                    editModalVC.selectedItemID = checkItemID
                    editModalVC.editAction = .updateCheckItemContent
                    
                    let placeholder = self?.checkItemRepository.getCheckItemContent(forId: checkItemID)
                    editModalVC.textFieldPlaceholder = placeholder
                    
                    self?.present(editModalVC, animated: true)
                }),
                
                // 메모 설정
                UIAction(title: "checklist_checkBoxMenuButton_secondMenu".localized, image: UIImage(systemName: Constant.SFSymbol.addMemoMenuItemIcon), handler: { _ in
                    print("Add Memo Menu Tapped")
                    
                    let editModalVC = EditModalViewController()
                    
                    editModalVC.modalTransitionStyle = .crossDissolve
                    editModalVC.modalPresentationStyle = .overCurrentContext
                    editModalVC.selectedItemID = checkItemID
                    editModalVC.editAction = .updateCheckItemMemo
                    
                    let placeholder = self?.checkItemRepository.getCheckItemMemo(forId: checkItemID) ?? ""
                    editModalVC.textFieldPlaceholder = placeholder
                    
                    self?.present(editModalVC, animated: true)
                }),
                
                // 삭제
                UIAction(title: "checklist_checkBoxMenuButton_thirdMenu".localized, image: UIImage(systemName: Constant.SFSymbol.deleteMemuItemIcon), attributes: .destructive, handler: { _ in
                    print("Delete Menu Tapped")
                    
                    let modalVC = DeleteModalViewController()
                    
                    modalVC.modalTransitionStyle = .crossDissolve
                    modalVC.modalPresentationStyle = .overCurrentContext
                    modalVC.selectedItemID = checkItemID
                    modalVC.deleteAction = .deleteCheckItem
                    
                    self?.present(modalVC, animated: true)
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
        print("deinit - ChecklistViewController")
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - CollectionView Delegate
extension ChecklistViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        guard let item = checklistDataSource.itemIdentifier(for: indexPath) else {
            print("item Error")
            return
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChecklistCollectionViewCell else {
            print("cell Error")
            return
        }
        
        guard let result = self.checkItemRepository.getCheckItemIsChecked(forId: item.id) else {
            print("result Error")
            return
        }
        
        let newIsChecked = !result
        self.checkItemRepository.updateCheckItemIsChecked(forId: item.id, newIsChecked: newIsChecked)
        cell.cellIsSelected = !cell.cellIsSelected
    }
}


//MARK: - Sheet Delegate
extension ChecklistViewController: UISheetPresentationControllerDelegate {
    
}
