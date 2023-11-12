# Tempi - 기준을 세우다!

<img src = "https://github.com/hwangyeri/SeSAC/assets/114602459/c9dc5044-a3c7-4077-b611-51164aba0af6.png" width="160" height="300">
<img src = "https://github.com/hwangyeri/SeSAC/assets/114602459/1652481b-bd2a-4854-91f5-fef66cb20301.png" width="160" height="300">
<img src = "https://github.com/hwangyeri/SeSAC/assets/114602459/d7d83765-aa4f-41f1-8a07-65c3b58f2440.png" width="160" height="300">
<img src = "https://github.com/hwangyeri/SeSAC/assets/114602459/4a2466d9-5e3e-46c5-95d7-ef7851560954.png" width="160" height="300">
<img src = "https://github.com/hwangyeri/SeSAC/assets/114602459/423479a2-aab5-45cb-8c02-8b192f3f648d.png" width="160" height="300">

### 0. 효율적인 계획 관리를 위해, 템플릿을 제공해주는 투두 앱입니다.
- `Default Data` 를 활용한 체크리스트 추천 / 템플릿 검색 / 나의 리스트 관리 기능 구현
- `Realm` 을 사용해서 체크리스트에 대한 `CRUD` 기능 구현
<br/>

[ 🔗 앱 스토어 링크](https://apps.apple.com/kr/app/tempi-%EA%B8%B0%EC%A4%80%EC%9D%84-%EC%84%B8%EC%9A%B0%EB%8B%A4/id6469019571)

[![Image Description](https://github.com/hwangyeri/SeSAC/assets/114602459/ca69410c-d181-4826-8aae-b3452b5d6852)](https://apps.apple.com/kr/app/tempi-%EA%B8%B0%EC%A4%80%EC%9D%84-%EC%84%B8%EC%9A%B0%EB%8B%A4/id6469019571)

<br/>

## 1. 개발 기간
- 2023.09.29 ~ 2023.10.31 (4주)
- 세부 개발 기간
 
| 진행 사항 | 진행 기간 | 세부 내용 |
| ------- | :----: | ------- |
| 기획 및 디자인                | `2023.09.22 ~ 2023.09.27` | UserFlow 및 디자인 초안 제작(Figma), 주요 기능 기획, 공수 산정 계획 |
| 프로젝트 설정, 개발 환경 구성    | `2023.09.28 ~ 2023.10.01` | Design Sysytem, Extension, 다국어 설정, DB Schema 작성 |
| 탐색 탭 UI 구현              | `2023.10.02 ~ 2023.10.08` | 템플릿 체크리스트 생성 플로우, 검색 화면 UI 구현 |
| Realm 도입 및 데이터 저장 기능  | `2023.10.09 ~ 2023.10.15` | 체크리스트 생성 시 Realm 저장 및 데이터 읽기 기능 추가 |
| 체크리스트 편집 기능           | `2023.10.16 ~ 2023.10.22` | 체크박스/메모/고정 CRUD 및 Toast, 템플릿 검색 기능 구현 |
| 홈 탭 UI 구현               | `2023.10.23 ~ 2023.10.25` | 체크리스트 데이터 필터링 및 핸들링, 체크리스트 생성 기능 추가 |
| 버그 픽스, 앱 심사 준비        | `2023.10.26 ~ 2023.10.31` | 버그 수정, mock-up, QA 및 개인정보 처리방침 준비, 앱 심사 제출 |
<br/>

### 1.1 개발 인원
- 개인 프로젝트
<br/>

## 2. 개발 환경
- Xcooe 15.0.1
- Deployment Target iOS 16.0
- 다크모드 지원
- 가로모드 미지원

<br/>

## 3. 기술 스택
- `UIKit`, `Singleton`, `Repository`
- `GCD`, `Extension`, `Protocol`, `Closure`
- `Design System`, `DarkMode`, `MVVM`
- `Autolayout`, `Compositional Layout`, `Diffable DataSource`
- `Snapkit`, `JSON parsing`, `Realm`, `Custom Toast`, `SwiftMessages`
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

## 5. 트러블 슈팅

## 6. 회고

## 7. 버전 정보

<br/>

---
## ＞ Commit Convention
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

FIXME: 디렉터리 구조, 화면별 주요 기능, 개발 일지


