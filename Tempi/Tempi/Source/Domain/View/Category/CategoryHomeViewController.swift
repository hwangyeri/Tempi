//
//  CategoryHomeViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import UIKit
import SnapKit
import RealmSwift

class CategoryHomeViewController: BaseViewController {
    
//    let realm = try! Realm()
    
    private let checkItemRepository = CheckItemTableRepository()
    
    private let mainView = CategoryHomeView()
    
    private var categoryDataSource: UICollectionViewDiffableDataSource<Int, CategoryDisplayModel>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(realm.configuration.fileURL)
        
        hideBackButtonTitle()
        configureCategoryDataSource()
        setNotificationCenter()
    }
    
    override func configureLayout() {
        mainView.categoryCollectionView.delegate = self
        mainView.searchBackgroundButton.addTarget(self, action: #selector(searchBackgroundButtonTapped), for: .touchUpInside)
        mainView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 노티 설정
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(createChecklistNameFromHomeNotificationObserver(notification:)), name: .createChecklistFromHome, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteChecklistAlertNotificationObserver(notification:)), name: .deleteChecklistAlert, object: nil)
    }
    
    // MARK: - 서치 버튼
    @objc private func searchBackgroundButtonTapped() {
        print(#function)
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    // MARK: - 플러스 버튼
    @objc private func plusButtonTapped() {
        print(#function)
        let editChecklistNameVC = EditChecklistNameViewController()
        editChecklistNameVC.modalTransitionStyle = .crossDissolve
        editChecklistNameVC.modalPresentationStyle = .overCurrentContext
        editChecklistNameVC.nameAction = .createChecklistFromHome
        self.present(editChecklistNameVC, animated: true)
    }
    
    // MARK: - 커스텀 체크리스트 생성 (노티)
    @objc func createChecklistNameFromHomeNotificationObserver(notification: NSNotification) {
        print(#function)
        if let newChecklistID = notification.userInfo?["newChecklistID"] as? ObjectId {
            let checklistVC = ChecklistViewController()
            checklistVC.selectedChecklistID = newChecklistID
            checkItemRepository.fetch(for: newChecklistID) { result in
                checklistVC.checkItemTasks = result
            }
            self.navigationController?.pushViewController(checklistVC, animated: true)
        } else {
            print(#function, "newChecklistID error")
        }
    }
    
    // MARK: - 체크리스트 삭제시 알럿 (노티)
    @objc func deleteChecklistAlertNotificationObserver(notification: NSNotification) {
        print(#function)
        showMessage(title: "showMessage_delete_title".localized, body: "showMessage_delete_body".localized)
    }
    
    // MARK: - CollectionView DataSource
    private func configureCategoryDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CategoryCollectionViewCell, CategoryDisplayModel> { cell, indexPath, itemIdentifier in
            cell.imageView.image = itemIdentifier.image
            cell.textLabel.text = itemIdentifier.text
        }
        
        categoryDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.categoryCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let categories: [CategoryDisplayModel] = CategoryDisplayModel.categories
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryDisplayModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(categories)
        categoryDataSource.apply(snapshot)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - CollectionView Delegate
extension CategoryHomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainView.categoryCollectionView {
            if let selectedCategory = categoryDataSource.itemIdentifier(for: indexPath) {
                let categoryDetailVC = CategoryDetailViewController()
                categoryDetailVC.categoryName = selectedCategory.text
                navigationController?.pushViewController(categoryDetailVC, animated: true)
            }
        }
    }
    
}
