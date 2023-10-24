//
//  EditModalViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/18.
//

import UIKit
import RealmSwift

enum EditAction {
    case updateCheckItemContent
    case updateCheckItemMemo
    case createCheckItem
}

class EditModalViewController: BaseViewController {
    
    var selectedChecklistID: ObjectId?
    var selectedCheckItemID: ObjectId?
    var editAction: EditAction?
    var textFieldPlaceholder: String?
    
    private let checklistRepository = ChecklistTableRepository()
    private let checkItemRepository = CheckItemTableRepository()
    
    private let mainView = EditModalView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .tGray400.withAlphaComponent(0.7)
        setLocalized()
        setNotificationCenter()
    }
    
    override func configureLayout() {
        mainView.textField.delegate = self
        mainView.textField.becomeFirstResponder()
        mainView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mainViewTapped))
        mainView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - 메인 뷰 클릭시 Dismiss
    @objc private func mainViewTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: mainView)
        DispatchQueue.main.async {
            // backView 제외한 영역을 탭 했는지 확인
            if !self.mainView.backView.frame.contains(location) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - 저장 버튼
    @objc private func saveButtonTapped() {
        print(#function)
        guard let action = editAction else {
            print("Edit action is not defined")
            return
        }
        
        switch action {
        case .updateCheckItemContent:
            handleUpdateCheckItemContent()
        case .updateCheckItemMemo:
            handleUpdateCheckItemMemo()
        case .createCheckItem:
            handleCreateCheckItem()
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
    
    // MARK: - 노티 설정
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: - 다국어 설정 분기처리
    private func setLocalized() {
        guard let action = editAction else {
            print("Edit action is not defined")
            return
        }
        
        switch action {
        case .updateCheckItemContent:
            contentActionSetLocalized()
        case .updateCheckItemMemo:
            memoActionSetLocalized()
        case .createCheckItem:
            createCheckItemActionSetLocalized()
        }
        
        guard let placeholder = textFieldPlaceholder else {
            print("TextField placeholder Error")
            return
        }
        
        DispatchQueue.main.async {
            self.mainView.textField.placeholder = "editModal_textField_placeholder".localized(with: placeholder)
        }
    }
    
    /// Check Item 내용 - 저장 버튼 핸들러
    private func handleUpdateCheckItemContent() {
        print(#function)
        guard let selectedCheckItemID = selectedCheckItemID else {
            print("selectedCheckItemID error")
            return
        }
        
        guard let textFieldText = mainView.textField.text else {
            print("textFieldText error")
            return
        }
        
        checkItemRepository.updateCheckItemContent(forId: selectedCheckItemID, newContent: textFieldText)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: .updateCheckItemContent, object: nil)
        }
    }
    
    /// Check Item 메모 - 저장 버튼 핸들러
    private func handleUpdateCheckItemMemo() {
        print(#function)
        guard let selectedCheckItemID = selectedCheckItemID else {
            print("selectedCheckItemID error")
            return
        }
        
        guard let textFieldText = mainView.textField.text else {
            print("textFieldText error")
            return
        }
        
        checkItemRepository.updateCheckItemMemo(forId: selectedCheckItemID, newMemo: textFieldText)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: .updateCheckItemMemo, object: nil)
        }
    }
    
    /// Check Item 생성 - 저장 버튼 핸들러
    private func handleCreateCheckItem() {
        print(#function)
        guard let selectedChecklistID = selectedChecklistID else {
            print("selectedChecklistID error")
            return
        }
        
        guard let textFieldText = mainView.textField.text else {
            print("textFieldText error")
            return
        }
        
        let item = CheckItemTable(checklistPK: selectedChecklistID, content: textFieldText, createdAt: Date(), memo: nil, alarmDate: nil, isChecked: false)
        checkItemRepository.createItem(item)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: .createCheckItem, object: nil)
        }
    }
    
    /// Check Item 내용 액션 - 다국어 설정
    private func contentActionSetLocalized() {
        DispatchQueue.main.async {
            self.mainView.mainLabel.text = "editModal_updateContent_mainLabel".localized
            self.mainView.subLabel.text = "editModal_updateContent_subLabel".localized
            self.mainView.maximumNumberOfCharactersLabel.text = "editModal_updateContent_maximumNumberOfCharactersLabel".localized
        }
    }
    
    /// Check Item 메모 액션  - 다국어 설정
    private func memoActionSetLocalized() {
        DispatchQueue.main.async {
            self.mainView.mainLabel.text = "editModal_updateMemo_mainLabel".localized
            self.mainView.subLabel.text = "editModal_updateMemo_subLabel".localized
            self.mainView.maximumNumberOfCharactersLabel.text = "editModal_updateMemo_maximumNumberOfCharactersLabel".localized
        }
    }
    
    /// Check Item 생성 액션 - 다국어 설정
    private func createCheckItemActionSetLocalized() {
        DispatchQueue.main.async {
            self.mainView.mainLabel.text = "editModal_createCheckItem_mainLabel".localized
            self.mainView.subLabel.text = "editModal_createCheckItem_subLabel".localized
            self.mainView.maximumNumberOfCharactersLabel.text = "editModal_createCheckItem_maximumNumberOfCharactersLabel".localized
        }
    }

}

// MARK: TextField Delegate
extension EditModalViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateButtonState()
    }
    
    private func updateButtonState() {
        guard let text = mainView.textField.text, !text.isEmpty else {
            print("TextField text Error")
            DispatchQueue.main.async {
                self.mainView.saveButton.isEnabled = false
                self.mainView.saveButton.backgroundColor = .tGray500
                self.mainView.currentNumberOfCharactersLabel.text = "0"
            }
            return
        }
        
        let currentCount = text.count

        DispatchQueue.main.async {
            self.mainView.currentNumberOfCharactersLabel.text = "editModal_currentNumberOfCharactersLabel".localized(with: currentCount)
            self.mainView.saveButton.isEnabled = true
            self.mainView.saveButton.backgroundColor = .tGray1000
        }
    }
    
}
