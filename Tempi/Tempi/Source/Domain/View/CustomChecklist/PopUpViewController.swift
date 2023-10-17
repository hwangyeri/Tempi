//
//  PopUpViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import RealmSwift

class PopUpViewController: BaseViewController {
    
    var selectedChecklistID: ObjectId?
    
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

        guard let selectedChecklistID = selectedChecklistID else {
            print(#function, "selectedChecklistID error")
            return
        }
        
        checklistRepository.deleteItem(forId: selectedChecklistID)
        checkItemRepository.deleteItem(forChecklistPK: selectedChecklistID)
        NotificationCenter.default.post(name: NSNotification.Name.deleteChecklist, object: nil)
        dismiss(animated: true)
    }
    
}
