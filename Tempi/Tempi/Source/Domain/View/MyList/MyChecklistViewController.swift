//
//  MyListViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit
import SnapKit
import RealmSwift

class MyChecklistViewController: BaseViewController {
    
    private var fixedChecklists: [ChecklistTable] = []
    private var todayChecklists: [ChecklistTable] = []
    private var yesterdayChecklists: [ChecklistTable] = []
    private var previousChecklists: [ChecklistTable] = []
    
    private let checklistRepository = ChecklistTableRepository()
    private let checkItemRepository = CheckItemTableRepository()
    private var sections: [[ChecklistTable]] = []

    let mainView = MyChecklistView()
    
    private var myListDataSource: UICollectionViewDiffableDataSource<Int, ChecklistTable>!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAndFilterChecklistData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(createChecklistNameFromMyNotificationObserver(notification:)), name: .createChecklistFromMy, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // FIXME: 체크리스트 생성 되는 경우(홈화면, 리스트 화면, 새로운 리스트에 추가하기), 체크리스트 이름 변경되는 경우, 노티 보내서 데이터 리로드 해주는 방식으로 변경하기?
        fetchAndFilterChecklistData()
    }

    override func configureLayout() {
        mainView.myListCollectionView.delegate = self
        mainView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 플러스 버튼
    @objc private func plusButtonTapped() {
        print(#function)
        let editChecklistNameVC = EditChecklistNameViewController()
        editChecklistNameVC.modalTransitionStyle = .crossDissolve
        editChecklistNameVC.modalPresentationStyle = .overCurrentContext
        editChecklistNameVC.nameAction = .createChecklistFromMy
        self.present(editChecklistNameVC, animated: true)
    }
    
    // MARK: - 커스텀 체크리스트 생성 (노티)
    @objc func createChecklistNameFromMyNotificationObserver(notification: NSNotification) {
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
    
    // MARK: - CollectionView Section Filtering Date
    private func fetchAndFilterChecklistData() {
        DispatchQueue.main.async {
            self.checklistRepository.fetch { allItems in
                guard let allItems = allItems else {
                    print("allItems Error")
                    return
                }
                
                self.sections = [self.fixedChecklists, self.todayChecklists, self.yesterdayChecklists, self.previousChecklists]
                self.configureMyListDataSource(with: self.sections)
                
                let today = Calendar.current.startOfDay(for: Date())
                let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
                
                // 고정된 리스트
                self.fixedChecklists = allItems.filter { $0.isFixed }
                
                // 오늘
                self.todayChecklists = allItems.filter { item in
                    Calendar.current.isDate(item.createdAt, inSameDayAs: today) && !self.fixedChecklists.contains(item)
                }
                
                // 어제
                self.yesterdayChecklists = allItems.filter { item in
                    Calendar.current.isDate(item.createdAt, inSameDayAs: yesterday) && !self.fixedChecklists.contains(item) && !self.todayChecklists.contains(item)
                }
                
                // 이전
                self.previousChecklists = allItems.filter { item in
                    !Calendar.current.isDate(item.createdAt, inSameDayAs: today) && !Calendar.current.isDate(item.createdAt, inSameDayAs: yesterday) && !self.fixedChecklists.contains(item) && !self.todayChecklists.contains(item) && !self.yesterdayChecklists.contains(item)
                }
                            
                let allSections = [self.fixedChecklists, self.todayChecklists, self.yesterdayChecklists, self.previousChecklists]
                self.configureMyListDataSource(with: allSections)
            }
        }
    }

    // MARK: - CollectionView DataSource
    private func configureMyListDataSource(with sections: [[ChecklistTable]]) {
        // 헤더 설정
        let headerRegistration = UICollectionView.SupplementaryRegistration<MyListHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] headerView, elementKind, indexPath in
            if let sections = self?.sections {
                if sections.indices.contains(indexPath.section) {
                    let currentSection = sections[indexPath.section]
                    if currentSection.isEmpty {
                        headerView.isHidden = true
                    } else {
                        headerView.isHidden = false
                        let sectionTitle: String
                        switch indexPath.section {
                        case 0:
                            sectionTitle = "myList_sectionTitle_0".localized // fixedChecklists
                            headerView.imageView.isHidden = false
                        case 1:
                            sectionTitle = "myList_sectionTitle_1".localized // todayChecklists
                            headerView.imageView.isHidden = true
                        case 2:
                            sectionTitle = "myList_sectionTitle_2".localized // yesterdayChecklists
                            headerView.imageView.isHidden = true
                        case 3:
                            sectionTitle = "myList_sectionTitle_3".localized // previousChecklists
                            headerView.imageView.isHidden = true
                        default:
                            sectionTitle = ""
                        }
                        headerView.titleLabel.text = sectionTitle
                        headerView.updateLayoutForHiddenImage(isHidden: headerView.imageView.isHidden)
                    }
                }
            }
        }
        
        // 셀 설정
        let cellRegistration = UICollectionView.CellRegistration<MyListCollectionViewCell, ChecklistTable> { cell, indexPath, itemIdentifier in
            cell.checklistNameLabel.text = itemIdentifier.checklistName
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "myList_checklistDateLabel".localized)
            let dateString = dateFormatter.string(from: itemIdentifier.createdAt)
            cell.checklistDateLabel.text = dateString
        }
        
        myListDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.myListCollectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        myListDataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, ChecklistTable>()
        var section = 0
        for checklists in sections {
            snapshot.appendSections([section])
            snapshot.appendItems(checklists, toSection: section)
            section += 1
        }

        // FIXME: 헤더만 apply 반응 느림, EmptyView 적용 필요
        myListDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - CollectionView Delegate
extension MyChecklistViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        guard let cell = myListDataSource.itemIdentifier(for: indexPath) else {
            print("cell error")
            return
        }
        let selectedChecklistID = cell.id
        let checklistVC = ChecklistViewController()
        checklistVC.selectedChecklistID = selectedChecklistID
        checkItemRepository.fetch(for: selectedChecklistID) { result in
            checklistVC.checkItemTasks = result
        }
        self.navigationController?.pushViewController(checklistVC, animated: true)
    }
    
}
