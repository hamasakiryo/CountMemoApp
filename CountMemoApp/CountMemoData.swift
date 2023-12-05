//
//  CountMemoData.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/22.
//

import SwiftUI
class CountMemoData: ObservableObject {
    
    @Published var memos: [CountMemo] = [
        CountMemo(title: "タイトル1", content: "内容1", date: "2023\n11/21", characterCount: 1000, includeSpace: false, includeNewLine: false, removeEnclosedText: false),
        CountMemo(title: "タイトル2", content: "内容2", date: "2023\n11/22", characterCount: 2000, includeSpace: false, includeNewLine: false, removeEnclosedText: false)
    ]
    
    func saveMemo(memo: CountMemo, memoTitleText: String, memoContentText: String, characterCount: Int) {
    if let index = memos.firstIndex(where: { $0.id == memo.id }) {
        memos[index].title = memoTitleText
        memos[index].content = memoContentText
        memos[index].characterCount = characterCount
        }
    }
    
    func addNewMemo(newMemoTitleText: String, newMemoContentText: String, characterCount: Int, includeSpace: Bool,
                    includeNewLine: Bool, removeEnclosedText: Bool) {
        let newMemo = CountMemo(title: newMemoTitleText, content: newMemoContentText, date: "2023\n11/23", characterCount: characterCount, includeSpace: includeSpace, includeNewLine: includeNewLine, removeEnclosedText: removeEnclosedText)
        
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
    
    func modifiedTextCharacterCount(text: String, includeSpace: Bool, includeNewLine: Bool, removeEnclosedText: Bool) -> Int {
        var modifiedText = text
        
        // includeSpaceがfalseの場合、テキストから空白を除去(デフォルトで文字数のカウントには空白が含まれない)
        if !includeSpace {
            modifiedText = modifiedText.replacingOccurrences(of: "[ 　]", with: "", options: .regularExpression)
        }
        //includeNewLineがfalseの場合、テキストから改行を除去(デフォルトで文字数のカウントには改行が含まれない)
        if !includeNewLine {
            modifiedText = modifiedText.replacingOccurrences(of: "\n", with: "")
        }
        
        //removeEnclosedTextがtrueの場合、テキストから'//'で囲まれた文字を除去(例: //文字// とすると「文字」が除去される)
        if removeEnclosedText {
            modifiedText = modifiedText.replacingOccurrences(of: "//(.*?)//", with: "", options: .regularExpression)
        }
        
        return modifiedText.count
    }
}
