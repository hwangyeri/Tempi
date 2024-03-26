//
//  EntryView.swift
//  Tempi
//
//  Created by Yeri Hwang on 2024/03/20.
//

import WidgetKit
import SwiftUI

// 위젯을 구성하는 View
struct TempiWidgetEntryView: View {
    var entry: ChecklistEntry
    
    // 위젯의 크기 정보를 얻기 위한 변수
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .foregroundStyle(.black)
                .frame(maxHeight: 50)
                .overlay(
                    HStack() {
                        Text("나의 Checklist")
                            .foregroundColor(.white)
                            .font(.pretendard(.pretendardSemiBold))
                            .padding(.leading, 16)
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.white)
                            .padding(.trailing, 16)
                    }
                )
            
            VStack(alignment: .leading, spacing: 6) {
                ForEach(0..<itemsToShow().count, id: \.self) { index in
                    let item = itemsToShow()[index]
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.checklistName)
                            .font(.subheadline)
                        Text(formatDate(item.createdAt))
                            .font(.caption)
                            .foregroundStyle(.gray)
                        if index < itemsToShow().count - 1 {
                            Divider()
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 5)
            Spacer()
        }
    }
    
    // 날짜 형식을 변경하는 함수
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    // 위젯 크기에 따라 표시할 항목 개수를 결정하는 함수
    func itemsToShow() -> [(checklistName: String, createdAt: Date)] {
        let itemCount: Int
        switch widgetFamily {
        case .systemMedium:
            itemCount = min(entry.checklistName.count, 2)
        case .systemLarge:
            itemCount = min(entry.checklistName.count, 6)
        default:
            itemCount = entry.checklistName.count
        }
        
        var items: [(checklistName: String, createdAt: Date)] = []
        for index in 0..<itemCount {
            items.append((entry.checklistName[index], entry.createdAt[index]))
        }
        return items
    }
}

