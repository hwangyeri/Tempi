//
//  DataManager.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/10.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    
    private init() {
        loadData() // JSON Data -> categoryDataList
//        print(categoryList, "---- categoryList")
    }
    
    var categoryList: [CategoryDefaultData] = []
    
    // JSON 파일을 읽고 데이터를 디코딩하여 categoryList에 저장하는 함수
    private func loadData() {
        // JSON 파일을 불러오는 코드
        if let jsonData = loadJSON(), let decodedData = try? JSONDecoder().decode(Category.self, from: jsonData) {
            // JSON 데이터를 categoryList에 저장
            self.categoryList = decodedData.categoryDefaultData
        } else {
            print("loadData Error")
        }
    }
    
    // 앱 번들에서 JSON 파일을 로드하는 함수
    private func loadJSON() -> Data? {
        // 1. 불러올 파일 이름
        let fileNm: String
        if let languageCode = Locale.current.language.languageCode?.identifier {
            if languageCode == "ko" {
                fileNm = "CategoryData_ko" // 한국어용 파일명
            } else {
                fileNm = "CategoryData_en" // 영어용 파일명
            }
        } else {
            fileNm = "CategoryData_en" // 기본 영어 파일명
        }
        
        // 2. 불러올 파일의 확장자명
        let extensionType = "json"
        
        // 3. 파일 위치
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
        
        do {
            // 4. 해당 위치의 파일을 Data로 초기화하기
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            // 5. 잘못된 위치나 불가능한 파일 처리 (수정필요)
            // 파일 읽기 실패 시 nil 반환
            print("Error loading JSON file: \(error)")
            return nil
        }
    }
    
}
