//
//  EditModalViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/18.
//

import UIKit
import RealmSwift

enum EditAction {
    case updateCheckItemContent // 체크 아이템 내용 수정
    case updateCheckItemMemo // 체크 아이템 메모 수정
    case createCheckItem // 체크 아이템 생성
    case createBookmarkItem // 즐겨찾기 아이템 생성
}

// FIXME: 분기처리 저장 핸들러 - 반복되는 코드 리팩토링

class EditModalViewController: BaseViewController {
    
    var selectedItemID: ObjectId?
    var editAction: EditAction?
    var textFieldPlaceholder: String?
    
    private var maximumCount: Int = 0
    
    private let checklistRepository = ChecklistTableRepository()
    private let checkItemRepository = CheckItemTableRepository()
    private let bookmarkRepository = BookmarkTableRepository()
    
    private let mainView = EditModalView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .tGray400.withAlphaComponent(0.7)
        
        setLocalized()
        setNotificationCenter()
        
        //print("viewDidLoad", mainView.textField.text?.count, mainView.textField.text)
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
        case .createBookmarkItem:
            handleCreateBookmarkItem()
        }
    }
    
    /// Check Item 내용 - 저장 버튼 핸들러
    private func handleUpdateCheckItemContent() {
        print(#function)
        guard let selectedItemID = selectedItemID else {
            print("selectedItemID error")
            return
        }
        
        guard let textFieldText = mainView.textField.text, !textFieldText.isEmpty else {
            print("textFieldText error")
            return
        }
        
        checkItemRepository.updateCheckItemContent(forId: selectedItemID, newContent: textFieldText)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: .updateCheckItemContent, object: nil)
        }
    }
    
    /// Check Item 메모 - 저장 버튼 핸들러
    private func handleUpdateCheckItemMemo() {
        print(#function)
        guard let selectedItemID = selectedItemID else {
            print("selectedItemID error")
            return
        }
        
        guard let textFieldText = mainView.textField.text, !textFieldText.isEmpty else {
            print("textFieldText error")
            return
        }
        
        checkItemRepository.updateCheckItemMemo(forId: selectedItemID, newMemo: textFieldText)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: .updateCheckItemMemo, object: nil)
        }
    }
    
    /// Check Item 생성 - 저장 버튼 핸들러
    private func handleCreateCheckItem() {
        print(#function)
        guard let selectedItemID = selectedItemID else {
            print("selectedChecklistID error")
            return
        }
        
        guard let textFieldText = mainView.textField.text, !textFieldText.isEmpty else {
            print("textFieldText error")
            return
        }
        
        let item = CheckItemTable(checklistPK: selectedItemID, content: textFieldText, createdAt: Date(), memo: nil, alarmDate: nil, isChecked: false)
        checkItemRepository.createItem(item)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: .createCheckItem, object: nil)
        }
    }
    
    /// Bookmark Item 생성 - 저장 버튼 핸들러
    private func handleCreateBookmarkItem() {
        print(#function)
        guard let textFieldText = mainView.textField.text, !textFieldText.isEmpty else {
            print("textFieldText error")
            return
        }
        
        let item = BookmarkTable(content: textFieldText, createdAt: Date())
        bookmarkRepository.createItem(item)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: .createBookmarkItem, object: nil)
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
        case .createBookmarkItem:
            createBookmarkItemActionSetLocalized()
        }
        
        guard let placeholder = textFieldPlaceholder else {
            print("TextField placeholder Error")
            return
        }
        
        DispatchQueue.main.async {
            self.mainView.textField.placeholder = "editModal_textField_placeholder".localized(with: placeholder)
        }
    }
    
    // MARK: - 다국어 설정
    private func setMaxCharacterCount(for labelKey: String) {
        DispatchQueue.main.async {
            self.mainView.mainLabel.text = "\(labelKey)_mainLabel".localized
            self.mainView.subLabel.text = "\(labelKey)_subLabel".localized
            self.mainView.maximumNumberOfCharactersLabel.text = "\(labelKey)_maximumNumberOfCharactersLabel".localized
        }
        
        let maxStr = "\(labelKey)_maximumNumberOfCharactersLabel".localized.suffix(2)
        print(maxStr, "--- maxStr ---")
        guard let maxInt = Int(maxStr) else {
            print("maxInt Error")
            return
        }
        self.maximumCount = maxInt
        print(maximumCount, "--- maximumCharacterCount ---")
    }

    /// Check Item 내용 액션 - 다국어 설정
    private func contentActionSetLocalized() {
        setMaxCharacterCount(for: "editModal_updateContent")
    }

    /// Check Item 메모 액션  - 다국어 설정
    private func memoActionSetLocalized() {
        setMaxCharacterCount(for: "editModal_updateMemo")
    }

    /// Check Item 생성 액션 - 다국어 설정
    private func createCheckItemActionSetLocalized() {
        setMaxCharacterCount(for: "editModal_createCheckItem")
    }

    /// Bookmark Item 생성 액션 - 다국어 설정
    private func createBookmarkItemActionSetLocalized() {
        setMaxCharacterCount(for: "editModal_createBookmarkItem")
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
        print(currentCount, "--- currentCount ---0")

        DispatchQueue.main.async {
            self.mainView.currentNumberOfCharactersLabel.text = "editModal_currentNumberOfCharactersLabel".localized(with: currentCount)
            self.mainView.saveButton.isEnabled = true
            self.mainView.saveButton.backgroundColor = .tGray1000
        }
        
        // maximumCharacterCount를 사용하여 버튼 활성화 상태 업데이트 - 최대 글자수 넘으면 버튼 비활성화 처리
        DispatchQueue.main.async {
            if currentCount > self.maximumCount {
                self.mainView.saveButton.isEnabled = false
                self.mainView.saveButton.backgroundColor = .tGray500
            } else {
                self.mainView.saveButton.isEnabled = true
                self.mainView.saveButton.backgroundColor = .tGray1000
            }
        }
    }
    
}
