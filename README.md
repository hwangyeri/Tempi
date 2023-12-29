# Tempi - 기준을 세우다!

<img src="https://github.com/hwangyeri/SeSAC/assets/114602459/c9dc5044-a3c7-4077-b611-51164aba0af6.png" width="160" height="300">
<img src="https://github.com/hwangyeri/SeSAC/assets/114602459/1652481b-bd2a-4854-91f5-fef66cb20301.png" width="160" height="300">
<img src="https://github.com/hwangyeri/SeSAC/assets/114602459/d7d83765-aa4f-41f1-8a07-65c3b58f2440.png" width="160" height="300">
<img src="https://github.com/hwangyeri/SeSAC/assets/114602459/4a2466d9-5e3e-46c5-95d7-ef7851560954.png" width="160" height="300">
<img src="https://github.com/hwangyeri/SeSAC/assets/114602459/423479a2-aab5-45cb-8c02-8b192f3f648d.png" width="160" height="300">

### 0. 효율적인 계획 관리를 위해, 템플릿을 제공해주는 투두 앱입니다.
- `JSON Data`를 활용해 템플릿 기반의 체크리스트 추천/검색 기능 제공
- 체크리스트 목록 관리 및 즐겨찾기 기능 제공
- `RealmSwift`을 이용해 체크리스트에 대한 `CRUD` 기능 제공
<br/>

### Link
[ 🔗 App Store ](https://apps.apple.com/kr/app/tempi-%EA%B8%B0%EC%A4%80%EC%9D%84-%EC%84%B8%EC%9A%B0%EB%8B%A4/id6469019571)

[ 🔗 Blog 앱 출시 회고 ](https://yeridev.tistory.com/entry/XFile-27)

<br/>

## 1. 개발 기간
- 2023.09.29 ~ 2023.10.31 (4주)
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

### 1.1 개발 인원
- 1명, 개인 프로젝트
<br/>

## 2. 개발 환경
- Xcooe 15.0.1
- Deployment Target iOS 16.0
- 다크모드 지원
- 가로모드 미지원
<br/>

## 3. 기술 스택
- `UIKit`, `CodeBaseUI`
- `MVC`, `Singleton`, `Repository`
- `Snapkit`, `Realm`, `GCD`
- `Autolayout`, `Compositional Layout`, `DiffableDataSource`
- `Design System`, `DarkMode`
- `JSON parsing`, `Toast`, `SwiftMessages`
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

## 4. 핵심 기능
- `Realm`을 이용해 Local DB CRUD
- `DiffableDataSource`를 사용해 `snapshot` 기반의 업데이트 관리 및 접근 방식 사용
- `Singleton` 패턴으로 하나의 객체만을 생성해 메모리 낭비 방지
- `NotificationCenter`를 통한 데이터 전달 및 알림 기능 구현
- `Custom View`를 이용해 UI 관리 및 재사용성 향상
- `Autolayout`을 통한 기기 대응 (iPhone SE, iPhone15 Max)
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

### 클로저의 메모리 누수
- 문제 상황 : 체크리스트 생성 플로우에서 몇 개의 뷰가 deinit이 안되었고, 강한 참조 순환으로 인한 메모리 누수가 발생하였습니다.
- 해결 방법 : 클로저 캡처 목록에 [weak self] 추가해서 메모리의 순환 참조를 방지하였습니다.

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

[ 🔗 Blog 해당 이슈에 대한 블로그 글 ](https://yeridev.tistory.com/entry/XFile-29)

<br/>

## 6. 버전 정보
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

## 7. UI/UX
- 설정 탭 추가한 후에 gif 파일 업데이트 예정
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

