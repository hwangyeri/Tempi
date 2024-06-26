//
//  CategoryDetailViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/03.
//

import UIKit

final class CategoryDetailViewController: BaseViewController {
    
    var categoryName: String?
    
    private var subCategoryList: [String] {
        // categoryName에 해당하는 subCategoryName만 필터링
        return JSONDataManager.shared.categoryList
            .filter { $0.categoryName == categoryName }
            .map { $0.subCategoryName }
    }
    
    private var selectedIndexPath: IndexPath?
    
    private let mainView = CategoryDetailView()
    
    private var subCategoryDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRightBarButton()
        hideBackButtonTitle()
        setLocalized()
        configureSubCategoryDataSource()
        
//        print("---- DetailView", categoryName)
//        print(subCategoryList)
    }
    
    override func configureLayout() {
        mainView.subCategoryCollectionView.delegate = self
        mainView.tButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 다음 버튼
    @objc private func nextButtonTapped() {
        if let selectedIndexPath = selectedIndexPath, let selectedSubCategory = subCategoryDataSource.itemIdentifier(for: selectedIndexPath) {
            let categoryChecklistVC = CategoryChecklistViewController()
            categoryChecklistVC.categoryName = categoryName
            categoryChecklistVC.subCategoryName = selectedSubCategory
            navigationController?.pushViewController(categoryChecklistVC, animated: true)
        }
    }
    
    // MARK: - 다국어 설정
    private func setLocalized() {
        guard let categoryName = categoryName else {
            return
        }
        mainView.mainLabel.text = "category_detail_main_label".localized(with: categoryName)
    }
    
    private func configureSubCategoryDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SubCategoryCollectionViewCell, String> {
            cell, indexPath, itemIdentifier in
            cell.textLabel.text = itemIdentifier
        }
        
        subCategoryDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.subCategoryCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        let uniqueItems = Set(subCategoryList) // 중복 제거
        snapshot.appendItems(Array(uniqueItems))
        subCategoryDataSource.apply(snapshot)
    }
    
    deinit {
        print("deinit - CategoryDetailViewController")
    }
}

// MARK: - CollectionView Delegate

extension CategoryDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? SubCategoryCollectionViewCell {
            // 이전에 선택된 cell UI 원래대로 복원
            if let prevSelectedIndexPath = selectedIndexPath,
               let prevSelectedCell = collectionView.cellForItem(at: prevSelectedIndexPath) as? SubCategoryCollectionViewCell {
                prevSelectedCell.backView.backgroundColor = .textFieldBackground
                prevSelectedCell.textLabel.textColor = .lightGray
                prevSelectedCell.textLabel.font = .customFont(.pretendardRegularL)
            }
            
            // 현재 선택된 cell UI 변경
            cell.backView.backgroundColor = .label
            cell.textLabel.textColor = .systemBackground
            cell.textLabel.font = .customFont(.pretendardSemiBoldL)
            
            // 현재 선택된 indexPath 저장
            selectedIndexPath = indexPath
            //print(selectedIndexPath)
            
            // tButton Disable 처리
            if selectedIndexPath == nil {
                mainView.tButton.isEnabled = false
                mainView.tButton.backgroundColor = .tButtonDisable
            } else {
                mainView.tButton.isEnabled = true
                mainView.tButton.backgroundColor = .label
            }
        }
    }
    
}
