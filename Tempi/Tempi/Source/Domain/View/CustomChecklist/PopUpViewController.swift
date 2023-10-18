//
//  PopUpViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import RealmSwift

enum PopUpAction {
    case deleteChecklist
    case deleteCheckItem
}

class PopUpViewController: BaseViewController {
    
    var selectedChecklistID: ObjectId?
    var selectedCheckItemID: ObjectId?
    var popUpAction: PopUpAction?
    
    private let checklistRepository = ChecklistTableRepository()
    private let checkItemRepository = CheckItemTableRepository()
    
    private let mainView = PopUpView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .tGray400.withAlphaComponent(0.7)
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
        
        guard let action = popUpAction else {
            print("PopUp action is not defined")
            return
        }
        
        switch action {
        case .deleteChecklist:
            handleDeleteChecklist()
        case .deleteCheckItem:
            handleDeleteCheckItem()
        }
    }
    
    private func handleDeleteChecklist() {
        guard let selectedChecklistID = selectedChecklistID else {
            print("selectedChecklistID error")
            return
        }
        
        checklistRepository.deleteItem(forId: selectedChecklistID)
        checkItemRepository.deleteAllCheckItem(forChecklistPK: selectedChecklistID)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name.deleteChecklist, object: nil)
        }
    }
    
    private func handleDeleteCheckItem() {
        guard let selectedCheckItemID = selectedCheckItemID else {
            print("selectedCheckItemID error")
            return
        }
        
        checkItemRepository.deleteCheckItem(withID: selectedCheckItemID)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name.deleteCheckItem, object: nil)
        }
    }
    
}
