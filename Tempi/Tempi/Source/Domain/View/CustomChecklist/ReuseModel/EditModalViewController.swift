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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func configureLayout() {
        mainView.textField.delegate = self
        mainView.textField.becomeFirstResponder()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mainViewTapped))
        mainView.addGestureRecognizer(tapGesture)
        mainView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 메인 뷰 클릭시 Dismiss
    @objc private func mainViewTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: mainView)
        
        // backView 제외한 영역을 탭 했는지 확인
        if !mainView.backView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
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
    
    // MARK: - 다국어 분기처리
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
            NotificationCenter.default.post(name: NSNotification.Name.updateCheckItemContent, object: nil)
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
            NotificationCenter.default.post(name: NSNotification.Name.updateCheckItemMemo, object: nil)
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
            NotificationCenter.default.post(name: NSNotification.Name.createCheckItem, object: nil)
        }
    }
    
    /// Check Item 내용 액션 - 다국어
    private func contentActionSetLocalized() {
        guard let placeholder = textFieldPlaceholder else {
            print("TextField placeholder Error")
            return
        }
        
        DispatchQueue.main.async {
            self.mainView.mainLabel.text = "editModal_updateContent_mainLabel".localized
            self.mainView.subLabel.text = "editModal_updateContent_subLabel".localized
            self.mainView.textField.placeholder = "editModal_textField_placeholder".localized(with: placeholder)
            self.mainView.maximumNumberOfCharactersLabel.text = "editModal_updateContent_maximumNumberOfCharactersLabel".localized
        }
    }
    
    /// Check Item 메모 액션  - 다국어
    private func memoActionSetLocalized() {
        guard let placeholder = textFieldPlaceholder else {
            print("TextField placeholder Error")
            return
        }
        
        DispatchQueue.main.async {
            self.mainView.mainLabel.text = "editModal_updateMemo_mainLabel".localized
            self.mainView.subLabel.text = "editModal_updateMemo_subLabel".localized
            self.mainView.textField.placeholder = "editModal_textField_placeholder".localized(with: placeholder)
            self.mainView.maximumNumberOfCharactersLabel.text = "editModal_updateMemo_maximumNumberOfCharactersLabel".localized
        }
    }
    
    /// Check Item 생성 액션 - 다국어
    private func createCheckItemActionSetLocalized() {
        guard let placeholder = textFieldPlaceholder else {
            print("TextField placeholder Error")
            return
        }
        
        DispatchQueue.main.async {
            self.mainView.mainLabel.text = "editModal_createCheckItem_mainLabel".localized
            self.mainView.subLabel.text = "editModal_createCheckItem_subLabel".localized
            self.mainView.textField.placeholder = "editModal_textField_placeholder".localized(with: placeholder)
            self.mainView.maximumNumberOfCharactersLabel.text = "editModal_createCheckItem_maximumNumberOfCharactersLabel".localized
        }
    }

}

// MARK: TextField Delegate
extension EditModalViewController: UITextFieldDelegate {
    
    // FIXME: 적었다가 지우면 현재 글자수 0 인데 버튼 활성화 됨...
   
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateButtonState()
    }
    
    private func updateButtonState() {
        guard let text = mainView.textField.text else {
            print("TextField text Error")
            return
        }
        let currentCount = text.count
        
        guard let action = editAction else {
            print("Edit action is not defined")
            return
        }
        
        switch action {
        case .updateCheckItemContent:
            guard let maximumCount = Int("editModal_updateContent_maximumNumberOfCharactersLabel".localized) else {
                print("maximumCount Error")
                return
            }
            
            DispatchQueue.main.async {
                self.mainView.currentNumberOfCharactersLabel.text = "editModal_updateContent_currentNumberOfCharactersLabel".localized(with: currentCount)
                
                if currentCount > maximumCount {
                    self.mainView.saveButton.isEnabled = false
                    self.mainView.saveButton.backgroundColor = .tGray500
                } else {
                    self.mainView.saveButton.isEnabled = true
                    self.mainView.saveButton.backgroundColor = .tGray1000
                }
            }
            
        case .updateCheckItemMemo:
            guard let maximumCount = Int("editModal_updateMemo_maximumNumberOfCharactersLabel".localized) else {
                print("maximumCount Error")
                return
            }
            
            DispatchQueue.main.async {
                self.mainView.currentNumberOfCharactersLabel.text = "editModal_updateMemo_currentNumberOfCharactersLabel".localized(with: currentCount)
                
                if currentCount > maximumCount {
                    self.mainView.saveButton.isEnabled = false
                    self.mainView.saveButton.backgroundColor = .tGray500
                } else {
                    self.mainView.saveButton.isEnabled = true
                    self.mainView.saveButton.backgroundColor = .tGray1000
                }
            }
        case .createCheckItem:
            guard let maximumCount = Int("editModal_createCheckItem_maximumNumberOfCharactersLabel".localized) else {
                print("maximumCount Error")
                return
            }
            
            DispatchQueue.main.async {
                self.mainView.currentNumberOfCharactersLabel.text = "editModal_createCheckItem_currentNumberOfCharactersLabel".localized(with: currentCount)
                
                if currentCount > maximumCount {
                    self.mainView.saveButton.isEnabled = false
                    self.mainView.saveButton.backgroundColor = .tGray500
                } else {
                    self.mainView.saveButton.isEnabled = true
                    self.mainView.saveButton.backgroundColor = .tGray1000
                }
            }
        }
    }

}
