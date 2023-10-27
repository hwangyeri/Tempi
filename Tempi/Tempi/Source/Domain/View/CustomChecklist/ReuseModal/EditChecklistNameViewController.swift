//
//  EditChecklistNameViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import RealmSwift

enum NameAction {
    case createChecklistFromHome
    case createChecklistFromMy
    case updateChecklistName
}

class EditChecklistNameViewController: BaseViewController {
    
    var selectedChecklistID: ObjectId?
    var textFieldPlaceholder: String?
    var nameAction: NameAction?
    
    private let checklistRepository = ChecklistTableRepository()
    
    private let mainView = EditChecklistNameView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func configureLayout() {
        
        DispatchQueue.main.async {
            self.mainView.textField.placeholder = self.textFieldPlaceholder
        }
        
        mainView.textField.delegate = self
        mainView.textField.becomeFirstResponder()
        mainView.exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        mainView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 나가기 버튼
    @objc private func exitButtonTapped() {
        print(#function)
        self.dismiss(animated: true)
    }
    
    // MARK: - 변경하기 버튼
    @objc private func editButtonTapped() {
        print(#function)
        
        guard let action = nameAction else {
            print("Name action is not defined")
            return
        }
        
        switch action {
        case .createChecklistFromHome:
            handleCreateChecklist()
        case .createChecklistFromMy:
            handleCreateChecklist()
        case .updateChecklistName:
            handleUpdateChecklistName()
        }
    }
    
    // MARK: - 키보드 나타날 때 (노티)
    @objc func keyboardWillShow(notification: NSNotification) {
        print(#function)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            DispatchQueue.main.async {
                self.mainView.updateButtonConstraints(keyboardHeight: keyboardHeight)
            }
        }
    }
    
    private func handleCreateChecklist() {
        guard let textFieldText = mainView.textField.text else {
            print("textFieldText error")
            return
        }
        
        let item = ChecklistTable(checklistName: textFieldText, createdAt: Date(), isFixed: false)
        checklistRepository.createItem(item)
        
        guard let newChecklistID = checklistRepository.getLatestChecklistId() else {
            print("newChecklistID error")
            return
        }
        
        var notificationName: NSNotification.Name?
        
        switch nameAction {
        case .createChecklistFromHome:
            notificationName = .createChecklistFromHome
        case .createChecklistFromMy:
            notificationName = .createChecklistFromMy
        default:
            return
        }
        
        if let name = notificationName {
            dismiss(animated: true) {
                NotificationCenter.default.post(name: name, object: nil, userInfo: ["newChecklistID": newChecklistID])
            }
        }
    }
    
    private func handleUpdateChecklistName() {
        guard let selectedChecklistID = selectedChecklistID else {
            print("selectedChecklistID error")
            return
        }
        
        guard let textFieldText = mainView.textField.text else {
            print("textFieldText error")
            return
        }
        
        checklistRepository.updateChecklistName(forId: selectedChecklistID, newChecklistName: textFieldText)
        NotificationCenter.default.post(name: .updateChecklistName, object: nil, userInfo: ["checklistName": textFieldText])
        
        self.dismiss(animated: true)
    }
    
}

// MARK: TextField Delegate
extension EditChecklistNameViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateButtonState()
    }
    
    private func updateButtonState() {
        guard let text = mainView.textField.text, !text.isEmpty else {
            DispatchQueue.main.async {
                self.mainView.editButton.isEnabled = false
                self.mainView.editButton.backgroundColor = .tGray500
            }
            return
        }
        
        DispatchQueue.main.async {
            self.mainView.editButton.isEnabled = true
            self.mainView.editButton.backgroundColor = .label
        }
    }
    
}
