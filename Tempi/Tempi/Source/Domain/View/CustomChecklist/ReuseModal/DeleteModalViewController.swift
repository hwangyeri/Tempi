//
//  DeleteModalViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import RealmSwift

enum DeleteAction {
    case deleteChecklist // 체크리스트 삭제
    case deleteCheckItem // 체크 아이템 삭제
    case deleteBookmarkItem // 즐겨찾기 아이템 삭제
}

class DeleteModalViewController: BaseViewController {
    
    var selectedItemID: ObjectId?
    var deleteAction: DeleteAction?
    
    private let checklistRepository = ChecklistTableRepository()
    private let checkItemRepository = CheckItemTableRepository()
    private let bookmarkRepository = BookmarkTableRepository()

    private let mainView = DeleteModalView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
    
    override func configureLayout() {
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 취소 버튼
    @objc private func cancelButtonTapped() {
        print(#function)
        dismiss(animated: true)
    }
    
    // MARK: - 삭제 버튼
    @objc private func deleteButtonTapped() {
        print(#function)
        
        guard let action = deleteAction else {
            print("Delete action is not defined")
            return
        }
        
        switch action {
        case .deleteChecklist:
            handleDeleteChecklist()
        case .deleteCheckItem:
            handleDeleteCheckItem()
        case .deleteBookmarkItem:
            handleDeleteBookmarkItem()
        }
    }
    
    private func handleDeleteChecklist() {
        guard let selectedChecklistID = selectedItemID else {
            print("selectedChecklistID error")
            return
        }
        
        checklistRepository.deleteItem(forId: selectedChecklistID)
        checkItemRepository.deleteAllCheckItem(forChecklistPK: selectedChecklistID)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: .deleteChecklist, object: nil)
        }
    }
    
    private func handleDeleteCheckItem() {
        guard let selectedItemID = selectedItemID else {
            print("selectedItemID error")
            return
        }
        
        checkItemRepository.deleteCheckItem(withID: selectedItemID)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: .deleteCheckItem, object: nil)
        }
    }
    
    private func handleDeleteBookmarkItem() {
        print(#function)
//        guard let selectedItemID = selectedItemID else {
//            print("selectedItemID error")
//            return
//        }
//        
//        bookmarkRepository.deleteItem(forId: selectedItemID)
//        dismiss(animated: true) {
//            NotificationCenter.default.post(name: .deleteBookmarkItem, object: nil)
//        }
    }
    
}
