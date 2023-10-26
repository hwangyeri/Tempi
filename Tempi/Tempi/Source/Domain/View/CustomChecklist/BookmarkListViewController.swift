//
//  BookmarkListViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/13.
//

import UIKit
import RealmSwift

class BookmarkListViewController: BaseViewController {
    
    var selectedItemID: ObjectId?
    var bookmarkTasks: Results<BookmarkTable>!
    
    private let bookmarkRepository = BookmarkTableRepository()
    
    private let mainView = BookmarkListView()
    
    private var bookmarkDataSource: UICollectionViewDiffableDataSource<Int, BookmarkTable>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setBookmarkListData()
        configureBookmarkDataSource()
    }
    
    override func configureLayout() {
        mainView.bookmarkListCollectionView.delegate = self
        mainView.addBookmarkItemButton.addTarget(self, action: #selector(addBookmarkItemButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 초기 데이터 설정
    private func setBookmarkListData() {
        // 현재 즐겨찾기 항목 개수 UI 업데이트
        let count = bookmarkRepository.getCountForAllItems()
        DispatchQueue.main.async {
            self.mainView.selectedItemCountLabel.text = "bookmarkList_selectedItemCountLabel".localized(with: count)
        }
    }
    
    // MARK: - NotificationCenter 설정
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(createBookmarkItemNotificationObserver(notification:)), name: .createBookmarkItem, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteBookmarkItemNotificationObserver(notification:)), name: .deleteBookmarkItem, object: nil)
    }
    
    // MARK: - 즐겨찾기 항목 생성 (노티)
    @objc private func createBookmarkItemNotificationObserver(notification: NSNotification) {
        print(#function)
        
        showToast(message: "showToast_create".localized)
        
        DispatchQueue.main.async {
            self.setBookmarkListData()
            self.configureBookmarkDataSource()
        }
    }
    
    // MARK: - 즐겨찾기 항목 삭제 (노티)
    @objc private func deleteBookmarkItemNotificationObserver(notification: NSNotification) {
        print(#function)
        
        showToast(message: "showToast_delete".localized)
        
        DispatchQueue.main.async {
            self.setBookmarkListData()
            self.configureBookmarkDataSource()
        }
    }
    
    // MARK: - 즐겨찾기 항목 추가 버튼
    @objc private func addBookmarkItemButtonTapped() {
        print(#function)
        let editModalVC = EditModalViewController()
        editModalVC.modalTransitionStyle = .crossDissolve
        editModalVC.modalPresentationStyle = .overCurrentContext
        editModalVC.textFieldPlaceholder = "placeholder"
        editModalVC.editAction = .createBookmarkItem
        self.present(editModalVC, animated: true)
    }
    
    // MARK: - 즐겨찾기 항목 삭제 버튼
    @objc private func deleteButtonTapped () {
        print(#function)
        guard let selectedItemID = selectedItemID else {
            print(#function, "selectedItemID error")
            return
        }
        
        let deleteModalVC = DeleteModalViewController()
        deleteModalVC.modalTransitionStyle = .crossDissolve
        deleteModalVC.modalPresentationStyle = .overCurrentContext
        deleteModalVC.selectedItemID = selectedItemID
        print(self.selectedItemID, "selectedItemID")
        deleteModalVC.deleteAction = .deleteBookmarkItem
        self.present(deleteModalVC, animated: true)
    }
    
    // MARK: - CollectionView DataSource
    private func configureBookmarkDataSource() {
        print(#function)
        
        // 데이터 없을시 emptyView 보여주기
        if bookmarkTasks.isEmpty {
            self.mainView.emptyView.isHidden = false
        } else {
            self.mainView.emptyView.isHidden = true
        }
        
        let cellRegistration = UICollectionView.CellRegistration<BookmarkListCollectionViewCell, BookmarkTable> {
            cell, indexPath, itemIdentifier in
            cell.checkBoxLabel.text = itemIdentifier.content
            
            self.selectedItemID = itemIdentifier.id
            cell.deleteButton.addTarget(self, action: #selector(self.deleteButtonTapped), for: .touchUpInside)
        }
        
        bookmarkDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.bookmarkListCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, BookmarkTable>()
        snapshot.appendSections([0])
        let result = Array(bookmarkTasks)
        snapshot.appendItems(result)
        bookmarkDataSource.apply(snapshot)
//        bookmarkDataSource.applySnapshotUsingReloadData(snapshot)
    }
    
}

// MARK: - CollectionView Delegate
extension BookmarkListViewController: UICollectionViewDelegate {
    
}
