//
//  Memo.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import Foundation

struct CountMemo: Identifiable {
    var id = UUID()
    var title: String
    var content: String
    var date: String
    var characterCount: Int
}

class CountMemoData: ObservableObject {
    @Published var memos: [CountMemo] = [
        CountMemo(title: "タイトル1", content: "内容1", date: "2023\n11/21", characterCount: 1000),
        CountMemo(title: "タイトル2", content: "内容2", date: "2023\n11/22", characterCount: 2000)
    ]
}
