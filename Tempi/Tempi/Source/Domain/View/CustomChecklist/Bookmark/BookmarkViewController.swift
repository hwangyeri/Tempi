//
//  BookmarkListViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/13.
//

import UIKit
import RealmSwift

final class BookmarkViewController: BaseViewController {
    
    var selectedChecklistID: ObjectId?
    
    private var selectedItems: [String] = [] {
        didSet {
            self.updateTButtonState()
        }
    }
    
    var bookmarkTasks: Results<BookmarkTable>!
    
    private let bookmarkRepository = BookmarkTableRepository()
    private let checkItemRepository = CheckItemTableRepository()
    
    private let mainView = BookmarkView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setBookmarkListData()
        setNotificationCenter()
    }
    
    override func configureLayout() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.addBookmarkItemButton.addTarget(self, action: #selector(addBookmarkItemButtonTapped), for: .touchUpInside)
        mainView.tButton.addTarget(self, action: #selector(tButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - 초기 데이터 설정
    private func setBookmarkListData() {
        print(#function)
        
        // 데이터 없을시 emptyView 보여주기
        if bookmarkTasks.isEmpty {
            self.mainView.emptyView.isHidden = false
        } else {
            self.mainView.emptyView.isHidden = true
        }
        
        // 현재 즐겨찾기 항목 개수 라벨 UI 업데이트
        let count = bookmarkRepository.getCountForAllItems()
        DispatchQueue.main.async { [weak self] in
            self?.mainView.selectedItemCountLabel.text = "bookmarkList_selectedItemCountLabel".localized(with: count)
        }
    }
    
    private func updateTButtonState() {
        // 리스트 추가하기 버튼 - 활성화/비활성화 상태 UI 업데이트
        mainView.tButton.isEnabled = !selectedItems.isEmpty
        mainView.tButton.backgroundColor = selectedItems.isEmpty ? .tButtonDisable : .label
    }
    
    //MARK: - NotificationCenter 설정
    private func setNotificationCenter() {
        print(#function)
        NotificationCenter.default.addObserver(self, selector: #selector(createBookmarkItemNotificationObserver), name: .createBookmarkItem, object: nil)
    }
    
    //MARK: - 즐겨찾기 항목 생성 (노티)
    @objc private func createBookmarkItemNotificationObserver(_ notification: NSNotification) {
        print(#function)
        
        showToast(message: "showToast_create".localized)
        
        DispatchQueue.main.async { [weak self] in
            self?.setBookmarkListData()
            self?.mainView.tableView.reloadData()
        }
    }
    
    //MARK: - 즐겨찾기 항목 추가 버튼
    @objc private func addBookmarkItemButtonTapped() {
        print(#function)
        let editModalVC = EditModalViewController()
        editModalVC.modalTransitionStyle = .crossDissolve
        editModalVC.modalPresentationStyle = .overCurrentContext
        editModalVC.textFieldPlaceholder = ""
        editModalVC.editAction = .createBookmarkItem
        self.present(editModalVC, animated: true)
    }
    
    //MARK: - 리스트에 추가하기 버튼
    @objc private func tButtonTapped() {
        print(#function)
        guard let ChecklistID = selectedChecklistID else {
            print("selectedChecklistID error")
            return
        }
        
        for content in selectedItems {
            let newItem = CheckItemTable(checklistPK: ChecklistID, content: content, createdAt: Date(), memo: nil, alarmDate: nil, isChecked: false)
            print("+++", content)
            print("+++", newItem)
            checkItemRepository.createItem(newItem)
        }
        
        NotificationCenter.default.post(name: .createCheckItem, object: nil)
        self.dismiss(animated: true)
    }
}

//MARK: - 테이블뷰
extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkTableViewCell.identifier, for: indexPath) as? BookmarkTableViewCell else { return UITableViewCell() }
        let row = bookmarkTasks[indexPath.row]
        
        cell.checkBoxLabel.text = row.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BookmarkTableViewCell else {
            print("TableViewCell Error")
            return
        }
        
        print("+++++", cell.isChecked)
        cell.isChecked.toggle()
        print("+++++", cell.isChecked)
        
        let content = bookmarkTasks[indexPath.row].content
        
        if cell.isChecked {
            selectedItems.append(content)
        } else {
            if let index = selectedItems.firstIndex(of: content) {
                selectedItems.remove(at: index)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let row = bookmarkTasks[indexPath.row]
            bookmarkRepository.deleteItem(forId: row.id)
            tableView.reloadData()
            setBookmarkListData()
        }
    }

}
