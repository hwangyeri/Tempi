# Tempi - 기준을 세우다!

![tempi_screenshot_mockup](https://github.com/hwangyeri/Tempi/assets/114602459/9d3cc8b0-2c1a-4df6-864d-d0bf056bb1ba)

### 효율적인 계획 관리를 위해, 템플릿을 제공해주는 투두 앱입니다.
- `JSON Data`를 활용해 템플릿 기반의 체크리스트 추천/검색 기능 제공
- 체크리스트 목록 관리 및 즐겨찾기 기능 제공
- `RealmSwift`을 이용해 체크리스트에 대한 `CRUD` 기능 제공
<br/>

### 앱 스토어 링크

🔗 [ Tempi - 기준을 세우다! ](https://apps.apple.com/kr/app/tempi-%EA%B8%B0%EC%A4%80%EC%9D%84-%EC%84%B8%EC%9A%B0%EB%8B%A4/id6469019571)

### 앱 출시 회고 링크

🔗 [ Tempi - 기준을 세우다! iOS 앱 출시 회고 ](https://yeridev.tistory.com/entry/XFile-27)

<br/>

## 1. 개발 환경
- Xcooe 15.0.1
- Deployment Target iOS 16.0
- 다크모드 지원
- 가로모드 미지원
- 다국어 대응
<br/>

## 2. 개인 프로젝트
- 개발 인원 : 1명
- 개발 기간 : 2023.09.29 ~ 2023.10.31 (4주)
- 세부 개발 기간
 
| 진행 사항 | 진행 기간 | 세부 내용 |
| ------- | :----: | ------- |
| 기획 및 디자인                | `2023.09.22 ~ 2023.09.27` | UserFlow 및 디자인 초안 제작(Figma), 주요 기능 기획, 공수 산정 계획 |
| 프로젝트 설정, 개발 환경 구성    | `2023.09.28 ~ 2023.10.01` | Design Sysytem, 다국어 설정, DB Schema 구상 |
| 탐색 탭 UI 구현              | `2023.10.02 ~ 2023.10.08` | 템플릿 체크리스트 생성 플로우, 검색 화면 UI 구현 |
| Realm 도입 및 데이터 저장 기능  | `2023.10.09 ~ 2023.10.15` | 체크리스트 생성 시 Realm 저장 및 데이터 읽기 기능 추가 |
| 체크리스트 편집 기능           | `2023.10.16 ~ 2023.10.22` | 체크박스/메모/고정 CRUD 및 Toast, 템플릿 검색 기능 구현 |
| 홈 탭 UI 구현               | `2023.10.23 ~ 2023.10.25` | 체크리스트 데이터 필터링/핸들링, 홈 화면 UI 및 기능 구현 |
| 버그 픽스, 앱 심사 준비        | `2023.10.26 ~ 2023.10.31` | 버그 수정, mock-up, QA 및 개인정보 처리방침 준비, 앱 심사 제출 |
<br/>

## 3. 기술 스택
- `UIKit`, `CodeBaseUI`
- `MVC`, `Singleton`, `Repository`
- `Autolayout`, `Compositional Layout`, `DiffableDataSource`
- `GCD`, `JSON parsing`, `Design System`
- `Snapkit`, `Realm`, `SwiftMessages`
- `Firebase Analytics`, `Firebase Crashlytics`, `FCM`
- `Localization`, `Local Notification`
<br/>

### 3.1 라이브러리
 
| 이름 | 버전 | 의존성 관리 |
| ------------- | :-------: | :---: |
| Firebase      | `10.17.0` | `SPM` |
| Realm         | `10.42.1` | `SPM` |
| SnapKit       | `5.6.0`   | `SPM` |
| SwiftMessages | `9.0.8`   | `SPM` |
<br/>

### 3.2 Tools
- `Figma/FigJam`, `Git/Github`, `Jandi`, `Notion`, `Discode`
<br/>

## 4. 기능 구현
- `SnapKit` 을 통한 `CodeBaseUI` 구현
- `Realm`과 `Repository` 패턴을 사용해 Local DB 구성 및 CRUD 기능 구현
- `DiffableDataSource`를 사용해 데이터 기반의 `snapshot` 업데이트 관리 및 접근 방식 구현
  - `Custom Header View`를 활용해 ~ 수정 필요
- `Custom View`와 `Design System`을 적용해 UI 관리, 유지 보수성 및 재사용성 향상
   - 다양한 `Custom Cell`을 사용해 다채로운 UI 구성
- `Constant`와 `Enum` 및 정적 변수를 사용해 로우한 스트링 값 사용을 줄이고, 메모리 최적화
- `Firebase Crashlytics, Analytics`를 통해 앱의 안정성 모니터링 및 크래시 추적
- `FCM`을 이용해 `Push Notification` 구현
<br/>

## 5. Trouble Shooting
### NotificationCenter Observer 등록 타이밍
- 문제 상황 : 초기 구현에서는 알림 게시 후 addObserver 과정이 발생했습니다. 이로 인해서 필요한 관찰자가 배치되기 전에 알림이 전송되서 화면에 알럿이 나타나지 않았습니다.
- 해결 방법 : NotificationCenter를 통해 데이터(체크리스트 생성 상태)를 전달하는 대신, UserDefaults를 사용해 저장된 데이터로 체크리스트 생성 상태 확인하고 사용자에게 Custom Alert을 표시해 주는 방법으로 변경하였습니다.

```swift
 extension UserDefaults {

        // 새로운 체크리스트를 생성하는 경우를 구분해서 Bool 값으로 저장, true == Custom Alert 띄워주기
        var isCreated: Bool {
            get {
                return UserDefaults.standard.bool(forKey: "isCreated")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "isCreated")
            }
        }
    }


    //MARK: - 체크리스트 생성 상태 확인 메서드
    private func isCreated() {
        print(#function)

        let isCreatedValue = UserDefaults.standard.bool(forKey: "isCreated")

        if isCreatedValue {
            // 새로운 체크리스트가 생성된 경우 Custom Alert 띄워주기
            showMessage(title: "showMessage_create_title".localized, body: "showMessage_create_body".localized)
            UserDefaults.standard.isCreated = false
        } else {
            print("Value is false")
        }
    }
```

#### 5-1. 해당 이슈에 대한 블로그 링크
🔗 [ NotificationCenter를 통한 값 전달 시 주의해야 할 점! ](https://yeridev.tistory.com/entry/XFile-29)

</br>

### 클로저의 메모리 누수
- 문제 상황 : Debug Memory Graph와 deinit을 통해 확인한 결과, 템플릿을 기반으로 체크리스트를 생성하는 플로우에서 몇 개의 뷰가 메모리에서 해제되지 않고 쌓이는 문제가 발생하였습니다.
- 해결 방법 : 클로저 캡처 목록에 [weak self] 추가해서 메모리의 순환 참조를 방지하고, 메모리 누수를 해결하였습니다.

```swift
 private func configureSubCategoryDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CategoryChecklistCollectionViewCell, String> {
            [weak self] cell, indexPath, itemIdentifier in
            cell.checkBoxLabel.text = itemIdentifier
            
            if let selectedItems = self?.selectedItems {
                cell.cellIsSelected = selectedItems.contains(itemIdentifier)
            } else {
                print("selectedItems Error")
            }
        }
        
        //코드 생략
    }

    @objc private func addToMyListButtonTapped() {
        //코드 생략
   
        repository.fetch { [weak self, weak addChecklistVC] tasks in
            guard let self = self, let addChecklistVC = addChecklistVC else {
                return
            }
            addChecklistVC.checklistTasks = tasks
            self.navigationController?.pushViewController(addChecklistVC, animated: true)
        }
    }
```

</br>

### DiffableDataSource 사용 시, 중복된 Item 값으로 인한 런타임 오류
- 문제 상황 : 사용자가 선택한 카테고리에 맞는 서브 카테고리 리스트를 보여주기 위해서 JSON Data를 필터링해서 CollectionView에 보이도록 구현했습니다. 하지만 특정한 Item을 클릭했을 때, 강제로 앱이 종료되는 런타임 에러가 발생하였습니다.
- 해결 방법 : 원인은 선택한 Item이 유니크하지 않아서 생기는 문제였습니다. 필터링 + 중복 제거한 새로운 배열을 snapshot에 넘겨줌으로 문제를 해결하였습니다.

```swift
// 이전 코드
private var checkItemList: [String] {
            return DataManager.shared.categoryList
                .filter { $0.categoryName == categoryName }
                .filter { $0.subCategoryName == subCategoryName }
                .map { $0.checkItem }
        }

// 개선된 코드
private var checkItemList: [String] {
        var uniqueCheckItems: [String] = []
        
        // categoryName 및 subCategoryName이 일치하는 항목(checkItem) 필터링 및 중복 제거
        for item in DataManager.shared.categoryList {
            if item.categoryName == categoryName, item.subCategoryName == subCategoryName, !uniqueCheckItems.contains(item.checkItem) {
                uniqueCheckItems.append(item.checkItem)
            }
        }
        
        return uniqueCheckItems
    }
```

<br/>

## 6. 프로젝트 회고
### Keep
- 수정 예정

### Problem • Try
- 수정 예정

<br/>

## 7. 버전 정보
### v1.0.0
- 2023.10.31 출시

### v1.0.1
- 2023.11.02 업데이트
- 체크리스트 화면 버그 수정

### v1.0.2
- 2023.11.15 업데이트
- `SwiftMessages`를 활용해 체크리스트 생성 알림 추가

### v1.0.3
- 2023.12.10 업데이트
- `Realm`를 이용한 즐겨찾기 기능 추가
<br/>

## 8. Commit Convention
```
- [Feat] 새로운 기능 구현
- [Style] UI 디자인 변경
- [Fix] 버그, 오류 해결
- [Refactor] 코드 리팩토링
- [Remove] 쓸모 없는 코드 삭제
- [Rename] 파일 이름/위치 변경
- [Chore] 빌드 업무, 패키지 매니저 및 내부 파일 수정
- [Comment] 필요한 주석 추가 및 변경
- [Test] 테스트 코드, 테스트 코드 리펙토링
```
<br/>

