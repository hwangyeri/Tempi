//
//  BookmarkListViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/13.
//

import UIKit
import RealmSwift

final class BookmarkListViewController: BaseViewController {
    
    var bookmarkTasks: Results<BookmarkTable>!
    
    private let bookmarkRepository = BookmarkTableRepository()
    
    private let mainView = BookmarkListView()
    
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
    
}

//MARK: - 테이블뷰
extension BookmarkListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkTableViewCell.identifier, for: indexPath) as? BookmarkTableViewCell else { return UITableViewCell() }
        let row = bookmarkTasks.first
        
        cell.checkBoxLabel.text = row?.content
        
        return cell
    }

}
