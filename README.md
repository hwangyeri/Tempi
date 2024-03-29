# Tempi - 기준을 세우다!

<img width="70" alt="스크린샷 2024-03-07 오전 1 36 13" src="https://github.com/hwangyeri/Tempi/assets/114602459/5e4599f0-a6c4-4340-b317-258740be91df">

### 효율적인 계획 관리를 위해, 템플릿을 제공해주는 투두 앱입니다.

![tempi_screenshot_mockup2](https://github.com/hwangyeri/Tempi/assets/114602459/ef2b4507-db9b-45e8-b3f3-86ca5c7b9bdf)

## 주요 기능
- 템플릿 기반의 체크리스트 추천 • 실시간 검색 기능 제공
- 투두 • 메모 • 즐겨찾기 기능 제공
- 날짜별 체크리스트 목록 관리 기능 제공
<br/>

![screenshotMockup](https://github.com/hwangyeri/Tempi/assets/114602459/73f2fe6a-3a1e-4253-93dd-ff759461fc08)


### 앱 스토어 링크

🔗 [ Tempi - 기준을 세우다! ](https://apps.apple.com/kr/app/tempi-%EA%B8%B0%EC%A4%80%EC%9D%84-%EC%84%B8%EC%9A%B0%EB%8B%A4/id6469019571)

### 앱 출시 회고 링크

🔗 [ Tempi - 기준을 세우다! iOS 앱 출시 회고 ](https://yeridev.tistory.com/entry/XFile-27)

<br/>

## 개발 환경
- **최소 버전** : iOS 16.0
- **개발 인원** : iOS/디자인/기획/백엔드 1인 개발
- **개발 기간** : 2023.09.29 ~ 2023.10.31 (4주)
- **기타** : Dark Mode 및 다국어 지원
<br/>

## 기술 스택
- `UIKit`, `CodeBaseUI`, `SPM`
- `MVC`, `MVVM`, `Singleton`, `Repository`, `Design System`
- `Autolayout`, `Compositional Layout`, `DiffableDataSource`
- `Realm`, `Snapkit`, `SwiftMessages`
- `Firebase Analytics`, `Firebase Crashlytics`, `FCM`
- `WidgetKit`, `Localization`, `Remote Notification`
<br/>

## 핵심 기술
- `Repository` Pattern을 이용한 DB Schema 구조화
- i18n, l10n 기반 `Localization` 구현
- `DiffableDataSource`를 이용한 데이터 기반의 `snapshot` 업데이트 및 관리
- `final`과 `private`과 같은 접근제어자를 이용한 은닉화 및 컴파일 최적화
- 다양한 `Custom Cell`을 이용한 다채로운 UI
- `Firebase Crashlytics, Analytics`를 통해 앱의 안정성 모니터링 및 크래시 추적
- `FCM`과 `APNs`를 이용한 푸시 알람(Remote Notification) 구현
- `App Groups`과 연동하여  앱과 `Widget Extension` 간 데이터 공유 및 동기화
<br/>

## 문제 해결
### 1. NotificationCenter Observer 등록 시점과 View가 생성되는 시점의 불일치
- 문제 상황 : 알림 게시 후 addObserver 과정으로 인해 필요한 관찰자가 배치 되기 전에 알림이 전송 되서 화면에 Alert이 나타나지 않음. 
- 해결 방법 : NotificationCenter를 이용해 데이터(체크리스트 생성 상태)를 전달하는 대신, UserDefaults를 이용해 Alert을 띄워주는 방법으로 문제를 해결함.

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

#### 1-1. 해당 이슈에 대한 블로그 링크
🔗 [ NotificationCenter를 통한 값 전달 시 주의해야 할 점! ](https://yeridev.tistory.com/entry/XFile-29)

</br>

### 2. Depth가 깊은 체크리스트 생성 플로우에서 메모리 누적 문제 발생
- 문제 상황 : Debug Memory Graph, Instruments 및 deinit을 통해 확인한 결과, 몇 개의 뷰가 메모리에서 해제되지 않고 쌓이는 문제가 발생함.
- 해결 방법 : 클로저 캡처 목록에 [weak self] 추가해서 메모리의 순환 참조를 방지하고, 메모리 누수를 해결함.
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

### 3. DiffableDataSource 사용 시, 중복된 Item 값으로 인한 런타임 오류
- 문제 상황 : 사용자가 선택한 카테고리에 맞는 서브 카테고리 리스트를 보여주기 위해서 JSON Data를 필터링해서 CollectionView에 표시했지만, 특정 Item을 클릭했을 때, 런타임 에러가 발생함.
- 해결 방법 : 선택한 Item이 유니크하지 않아서 생기는 문제로 필터링 후 중복을 제거한 새로운 배열을 snapshot에 전달하여 문제를 해결함.

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

## 프로젝트 회고
### Keep
1. Tempi는 첫 개인 앱 출시 프로젝트로 기획부터 출시까지의 모든 과정을 경험할 수 있었습니다. 개발 공수를 계획하고 진행하면서 디자인, User Flow, DB Schema가 여러 번 변경되었습니다. 이러한 경험을 통해 변경 사항에 대한 불필요한 수정 최소화하고, 예상보다 많은 시간이 소요되는 부분에 대한 원인을 분석하고 보완하는 방법을 배웠습니다.

2. 또한, 사용자의 편의성을 최우선으로 두어 기능을 개선하고 다양한 테스트를 반복하여 더 나은 사용자 경험을 제공하기 위해 노력했습니다.

### Problem • Try
1. 프로젝트 출시 기한에 맞추기 위해 중복적인 코드를 작성하게 되었습니다. 이로 인해, 코드의 가독성이 떨어지고 유지보수 측면에서 어려움이 생겼습니다. 모듈화 작업을 통해 가독성과 유지보수 측면을 개선할 계획입니다.

2. 해당 프로젝트는 MVC 구조로 설계 되었지만, 일부 구현된 로직이 각 구조에 맞지 않는 경우가 있었습니다. 역할에 맞지 않는 불필요한 로직을 제거하고, 구조에 맞게 로직을 수정하여 가독성과 유지보수성을 향상시킬 예정입니다.

3. 또한, MVC 패턴에서 Controller의 역할이 너무 비대해보였습니다. 다음에는 비즈니스 로직을 따로 분리할 수 있도록 MVVM 패턴을 도입하여 개선할 계획입니다.

<br/>

## 버전 정보
### v1.0.0
- 2023.10.31 출시

### v1.0.1
- 2023.11.02 업데이트
- 체크리스트 화면 버그 수정

### v1.0.2
- 2023.11.15 업데이트
- 체크리스트 생성 시, 커스텀 알럿 추가

### v1.0.3
- 2023.12.10 업데이트
- 즐겨찾기 기능 추가

### v1.1.0
- 2024.1.2 업데이트
- 설정 화면 및 문의하기 기능 추가

### v1.1.1
- 2024.3.26 업데이트
- 불필요한 코드 제거 및 개선

### v1.2.0
- 2024.3.27 업데이
- 위젯 기능 추가
<br/>

## Commit Convention
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

## 개발 공수
 
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

