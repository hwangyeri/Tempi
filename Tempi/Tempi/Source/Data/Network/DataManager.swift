//
//  DataManager.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/10.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() {
        loadData() // JSON Data -> categoryDataList
    }
    
    var categoryList: [CategoryDefaultData] = []
    
    // JSON 파일을 읽고 데이터를 디코딩하여 categoryList에 저장하는 함수
    private func loadData() {
        // JSON 파일을 불러오는 코드
        if let jsonData = load(), let decodedData = try? JSONDecoder().decode(Category.self, from: jsonData) {
            // JSON 데이터를 categoryList에 저장
            self.categoryList = decodedData.categoryDefaultData
        }
    }
    
    // 앱 번들에서 JSON 파일을 로드하는 함수
    private func load() -> Data? {
        // 1. 불러올 파일 이름
        let fileNm: String = "CategoryData"
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
            return nil
        }
    }
    
}
