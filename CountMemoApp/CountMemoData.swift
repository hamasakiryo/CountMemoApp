//
//  CountMemoData.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/22.
//

import SwiftUI
class CountMemoData: ObservableObject {
    // 文字数を数える際に空白を含めるかどうかを切り替えるためのフラグ
    @Published var includeSpace = false
    
    //改行を含めるかどうかを切り替えるフラグ
    @Published var includeNewLine = false
    
    //'//'で囲った文字を含めるかどうかを切り替えるフラグ
    @Published var removeEnclosedText = false
    
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
    
    // 修正されたテキストの文字数をカウントする関数
    func modifiedTextCharacterCount(text: String) -> Int {
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
