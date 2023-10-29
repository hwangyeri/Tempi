//
//  MyListViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit
import SnapKit
import RealmSwift

class MyListViewController: BaseViewController {
    
    private var fixedChecklists: [ChecklistTable] = []
    private var todayChecklists: [ChecklistTable] = []
    private var yesterdayChecklists: [ChecklistTable] = []
    private var previousChecklists: [ChecklistTable] = []
    
    private let checklistRepository = ChecklistTableRepository()
    private let checkItemRepository = CheckItemTableRepository()
    
    var storeDic: [Int: Int] = [:] // [indexPathSection: headerSection]
    
    let mainView = MyListView()
    
    private var myListDataSource: UICollectionViewDiffableDataSource<Int, ChecklistTable>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAndFilterChecklistData()
        setNotificationCenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // FIXME: 노티 보내서 데이터 리로드 해주는 방식으로 변경하기
        // 체크리스트 생성(홈화면, 리스트 화면, 새로운 리스트에 추가하기), 체크리스트 이름 변경, 체크리스트 삭제...
        fetchAndFilterChecklistData()
    }
    
    override func configureLayout() {
        mainView.myListCollectionView.delegate = self
        mainView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - NotificationCenter 설정
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(createChecklistNameFromMyNotificationObserver(notification:)), name: .createChecklistFromMy, object: nil)
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
        self.checklistRepository.fetch { allItems in
            guard let allItems = allItems else {
                print("allItems Error")
                return
            }
            
            if allItems.isEmpty {
                self.mainView.emptyView.isHidden = false
            } else {
                self.mainView.emptyView.isHidden = true
            }
            
            let today = Calendar.current.startOfDay(for: Date())
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
            
            // 고정된 리스트
            self.fixedChecklists = allItems.filter { $0.isFixed }
            //print("--- fixedChecklists ---", self.fixedChecklists)
            
            // 오늘
            self.todayChecklists = allItems.filter { item in
                Calendar.current.isDate(item.createdAt, inSameDayAs: today) && !self.fixedChecklists.contains(item)
            }
            //print("--- todayChecklists ---", self.todayChecklists)
            
            // 어제
            self.yesterdayChecklists = allItems.filter { item in
                Calendar.current.isDate(item.createdAt, inSameDayAs: yesterday) && !self.fixedChecklists.contains(item) && !self.todayChecklists.contains(item)
            }
            //print("--- yesterdayChecklists ---", self.yesterdayChecklists)
            
            
            // 이전
            self.previousChecklists = allItems.filter { item in
                !Calendar.current.isDate(item.createdAt, inSameDayAs: today) && !Calendar.current.isDate(item.createdAt, inSameDayAs: yesterday) && !self.fixedChecklists.contains(item) && !self.todayChecklists.contains(item) && !self.yesterdayChecklists.contains(item)
            }
            //print("--- previousChecklists ---", self.previousChecklists)
            
            let allSections: [[ChecklistTable]] = [self.fixedChecklists, self.todayChecklists, self.yesterdayChecklists, self.previousChecklists]
            //print("--- allSections ---", allSections)
            
            DispatchQueue.main.async {
                self.configureMyListDataSource(with: allSections)
            }
        }
    }
    
    // MARK: - CollectionView DataSource
    
    private func configureMyListDataSource(with allSections: [[ChecklistTable]]) {
        // 헤더 설정
        let headerRegistration = UICollectionView.SupplementaryRegistration<MyListHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] headerView, elementKind, indexPath in
            let sectionHeaderTitle: String
            let indexPathSection = indexPath.section
            print(indexPathSection)
            let headerSection = self?.storeDic[indexPathSection]
            //print("--- indexPathSection, headerSection ---", indexPathSection, headerSection)
            
            switch headerSection {
            case 0: // 고정된 리스트 - fixedChecklists
                sectionHeaderTitle = "myList_sectionTitle_0".localized
                headerView.imageView.isHidden = false // header Image 0번 Section 만 적용
            case 1: // 오늘 - todayChecklists
                sectionHeaderTitle = "myList_sectionTitle_1".localized
                headerView.imageView.isHidden = true
            case 2: // 어제 - yesterdayChecklists
                sectionHeaderTitle = "myList_sectionTitle_2".localized
                headerView.imageView.isHidden = true
            case 3: // 이전 - previousChecklists
                sectionHeaderTitle = "myList_sectionTitle_3".localized
                headerView.imageView.isHidden = true
            default:
                sectionHeaderTitle = ""
            }
            
            headerView.titleLabel.text = sectionHeaderTitle
            //print("--- sectionHeaderTitle ---", sectionHeaderTitle)
            headerView.updateLayoutForHiddenImage(isHidden: headerView.imageView.isHidden)
        }
        
        // 셀 설정
        let cellRegistration = UICollectionView.CellRegistration<MyListCollectionViewCell, ChecklistTable> { cell, indexPath, itemIdentifier in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "myList_checklistDateLabel".localized)
            
            let dateString = dateFormatter.string(from: itemIdentifier.createdAt)
            cell.checklistDateLabel.text = dateString
            cell.checklistNameLabel.text = itemIdentifier.checklistName
        }
        
        myListDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.myListCollectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        myListDataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, ChecklistTable>()
        var section = 0
        print("--- allSections ---", allSections)
        
//        for i in 0..<sections.count {
//            print(i, sections[i].count)
////            snapshot.appendSections([i])
//            if sections[i].isEmpty {
//                continue
//            }
//
//            snapshot.appendSections([section])
//            dic[section] = i
//            print(snapshot.numberOfItems(inSection: i))
//            snapshot.appendItems(sections[i], toSection: section)
//            section += 1
//        }
        
        for (index, checklists) in allSections.enumerated() {
            if checklists.isEmpty {
                continue
            }
            snapshot.appendSections([section])
            storeDic[section] = index // [indexPathSection: headerSection]
            snapshot.appendItems(checklists, toSection: section)
            section += 1
        }
        
//        print("numberOfSections", snapshot.numberOfSections)
//        
//        for i in 0..<snapshot.numberOfSections {
//            print(snapshot.numberOfItems(inSection: i))
//        }
        
        self.myListDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - CollectionView Delegate
extension MyListViewController: UICollectionViewDelegate {
    
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
