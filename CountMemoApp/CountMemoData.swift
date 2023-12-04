//
//  CountMemoData.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/22.
//

import SwiftUI
class CountMemoData: ObservableObject {
    @Published var memos: [CountMemo] = [
        CountMemo(title: "タイトル1", content: "内容1", date: "2023\n11/21", characterCount: 1000),
        CountMemo(title: "タイトル2", content: "内容2", date: "2023\n11/22", characterCount: 2000)
    ]
    
    func saveMemo(memo: CountMemo, memoTitleText: String, memoContentText: String, characterCount: Int) {
    if let index = memos.firstIndex(where: { $0.id == memo.id }) {
        memos[index].title = memoTitleText
        memos[index].content = memoContentText
        memos[index].characterCount = characterCount
        }
    }
    
    func addNewMemo(newMemoTitleText: String, newMemoContentText: String, characterCount: Int) {
        let newMemo = CountMemo(title: newMemoTitleText, content: newMemoContentText, date: "2023\n11/23", characterCount: characterCount)
        
        memos.insert(newMemo, at: 0)
    }
    
    func removeEmptyMemo() {
        guard !memos.isEmpty else {
            return
        }
        
        if memos[0].title.isEmpty && memos[0].content.isEmpty {
           memos.remove(at: 0)
        }
    }
}
