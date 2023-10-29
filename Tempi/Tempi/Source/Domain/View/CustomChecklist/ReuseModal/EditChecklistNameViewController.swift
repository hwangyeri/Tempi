//
//  EditChecklistNameViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import RealmSwift

enum NameAction {
    case createChecklistFromHome // 체크리스트 생성시 이름 설정 (홈 화면)
    case createChecklistFromMy // 체크리스트 생성시 이름 설정 (나의 리스트 화면)
    case updateChecklistName // 체크리스트 이름 변경
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
        
        setLocalized()
        setNotificationCenter()
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
    
    // MARK: - 다국어 설정
    private func setLocalized() {
        guard let action = nameAction else {
            print("Name action is not defined")
            return
        }
        
        switch action {
        case .createChecklistFromHome:
            DispatchQueue.main.async {
                self.mainView.mainLabel.text = "editChecklistName_mainLabel_create".localized
            }
        case .createChecklistFromMy:
            DispatchQueue.main.async {
                self.mainView.mainLabel.text = "editChecklistName_mainLabel_create".localized
            }
        case .updateChecklistName:
            DispatchQueue.main.async {
                self.mainView.mainLabel.text = "editChecklistName_mainLabel_update".localized
            }
        }
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
    
    /// Checklist Name 생성 (홈/나의) - 저장 버튼 핸들러
    private func handleCreateChecklist() {
        guard let textFieldText = mainView.textField.text, !textFieldText.isEmpty else {
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
            print(#function, "Name action is not defined")
            return
        }
        
        if let name = notificationName {
            dismiss(animated: true) {
                NotificationCenter.default.post(name: name, object: nil, userInfo: ["newChecklistID": newChecklistID])
            }
        }
    }
    
    /// Checklist Name 업데이트 - 저장 버튼 핸들러
    private func handleUpdateChecklistName() {
        guard let selectedChecklistID = selectedChecklistID else {
            print("selectedChecklistID error")
            return
        }
        
        guard let textFieldText = mainView.textField.text, !textFieldText.isEmpty else {
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
                self.mainView.currentNumberOfCharactersLabel.text = "0"
                self.mainView.editButton.isEnabled = false
                self.mainView.editButton.backgroundColor = .tGray500
            }
            return
        }
        
        let currentCount = text.count
        print(currentCount, "--- currentCount ---")
        
        DispatchQueue.main.async {
            if currentCount < 61 {
                self.mainView.currentNumberOfCharactersLabel.text = String(currentCount)
                self.mainView.editButton.isEnabled = true
                self.mainView.editButton.backgroundColor = .label
            } else {
                self.mainView.currentNumberOfCharactersLabel.text = String(currentCount)
                self.mainView.editButton.isEnabled = false
                self.mainView.editButton.backgroundColor = .tGray500
            }
        }
    }
    
}
