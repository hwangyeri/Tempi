//
//  EditChecklistNameViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/16.
//

import UIKit
import RealmSwift

class EditChecklistNameViewController: BaseViewController {
    
    var selectedChecklistID: ObjectId?
    var textFieldPlaceholder: String?
    
    private let checklistRepository = ChecklistTableRepository()
    
    private let mainView = EditChecklistNameView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        
        guard let selectedChecklistID = selectedChecklistID else {
            print("selectedChecklistID error")
            return
        }
        
        guard let textFieldText = mainView.textField.text else {
            print("textFieldText error")
            return
        }
        
        checklistRepository.updateChecklistName(forId: selectedChecklistID, checklistName: textFieldText)
        NotificationCenter.default.post(name: NSNotification.Name.updateChecklistName, object: nil, userInfo: ["checklistName": textFieldText])
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
    
    // MARK: - 키보드 사라질 때 (노티)
    @objc func keyboardWillHide(notification: NSNotification) {
        print(#function)
        DispatchQueue.main.async {
            self.mainView.setButtonConstraints()
        }
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
                self.mainView.editButton.backgroundColor = .tGray400
            }
            return
        }
        
        DispatchQueue.main.async {
            self.mainView.editButton.isEnabled = true
            self.mainView.editButton.backgroundColor = .tGray1000
        }
    }
    
}
