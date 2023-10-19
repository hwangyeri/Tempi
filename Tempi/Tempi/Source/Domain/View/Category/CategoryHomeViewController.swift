//
//  CategoryHomeViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/30.
//

import UIKit
import SnapKit
import RealmSwift

enum CollectionViewType {
    case category
    case recommendSearchWords
}

class CategoryHomeViewController: BaseViewController {
    
//    let realm = try! Realm()
    
    private var recommendSearchWordsList: [String] = []
    
    private let mainView = CategoryHomeView()
    
    private var recommendSearchWordsDataSource: UICollectionViewDiffableDataSource<Int, String>!
    private var categoryDataSource: UICollectionViewDiffableDataSource<Int, CategoryDisplayModel>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomSubCategories = getRandomSubCategories()
        recommendSearchWordsList = randomSubCategories
        
//        print(realm.configuration.fileURL)
//        print("randomSubCategories ----->", randomSubCategories)
//        print("recommendSearchWordsList ----->", recommendSearchWordsList)
        
        configureRecommendSearchWordsDataSource()
        configureCategoryDataSource()
        
        NotificationCenter.default.addObserver(self, selector: #selector(createChecklistNameNotificationObserver(notification:)), name: NSNotification.Name.createChecklist, object: nil)
    }
    
    override func configureLayout() {
        mainView.searchBar.delegate = self
        mainView.categoryCollectionView.delegate = self
        mainView.recommendSearchWordsCollectionView.delegate = self
        mainView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    @objc private func plusButtonTapped() {
        print(#function)
        let editChecklistNameVC = EditChecklistNameViewController()
        editChecklistNameVC.modalTransitionStyle = .crossDissolve
        editChecklistNameVC.modalPresentationStyle = .overCurrentContext
        editChecklistNameVC.nameAction = .createChecklist
        self.present(editChecklistNameVC, animated: true)
    }
    
    // MARK: - 커스텀 체크리스트 생성 (노티)
    @objc func createChecklistNameNotificationObserver(notification: NSNotification) {
        print(#function)
        
        if let newChecklistID = notification.userInfo?["checklistID"] as? ObjectId {
            let checklistVC = ChecklistViewController()
            checklistVC.selectedChecklistID = newChecklistID
            self.navigationController?.pushViewController(checklistVC, animated: true)
        } else {
            print(#function, "newChecklistID error")
        }
    }
    
    private func getRandomSubCategories() -> [String] {
        // 중복 없이 5개의 subCategoryName 추출
        let data = DataManager.shared.categoryList
        var randomSubCategories: Set<String> = []
        while randomSubCategories.count < 5 {
            let randomCategory = data.randomElement()
            if let randomSubCategory = randomCategory?.subCategoryName {
                randomSubCategories.insert(randomSubCategory)
            }
        }
        
        return Array(randomSubCategories)
    }
    
    private func configureRecommendSearchWordsDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ReuseSearchWordsCollectionViewCell, String> {
            cell, indexPath, itemIdentifier in
            cell.searchWordsLabel.text = itemIdentifier
        }
        
        recommendSearchWordsDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.recommendSearchWordsCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(recommendSearchWordsList)
        recommendSearchWordsDataSource.apply(snapshot)
    }
    
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
    
}

// MARK: - CollectionView Delegate

extension CategoryHomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var collectionViewType: CollectionViewType?
        
        switch collectionView {
        case mainView.categoryCollectionView:
            collectionViewType = .category
        case mainView.recommendSearchWordsCollectionView:
            collectionViewType = .recommendSearchWords
        default:
            break
        }
        
        guard let type = collectionViewType else {
            return // collectionViewType이 nil인 경우, 함수 종료
        }
        
        switch type {
        case .category:
            let selectedCategory = categoryDataSource.itemIdentifier(for: indexPath)
            let categoryDetailVC = CategoryDetailViewController()
            categoryDetailVC.categoryName = selectedCategory?.text
            navigationController?.pushViewController(categoryDetailVC, animated: true)
        case .recommendSearchWords:
            let selectedItem = recommendSearchWordsList[indexPath.item]
            let categoryChecklistVC = CategoryChecklistViewController()
            print(selectedItem)
            navigationController?.pushViewController(categoryChecklistVC, animated: true)
        }
    }
    
}

// MARK: - SearchBar

extension CategoryHomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
}
