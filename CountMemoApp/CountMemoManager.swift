//
//  CountMemoData.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/22.
//

import SwiftUI

class CountMemoManager: ObservableObject {
    
    @Published var memos: [CountMemo] = []
    
    func saveEditMemo(memo: CountMemo, memoTitleText: String, memoContentText: String, characterCount: Int,includeSpace: Bool, includeNewLine: Bool, removeEnclosedText: Bool, switchCountdown: Bool) {
    if let index = memos.firstIndex(where: { $0.id == memo.id }) {
        memos[index].title = memoTitleText
        memos[index].content = memoContentText
        memos[index].characterCount = characterCount
        memos[index].includeSpace = includeSpace
        memos[index].includeNewLine = includeNewLine
        memos[index].removeEnclosedText = removeEnclosedText
        memos[index].switchCountdown = switchCountdown
        }
    }
    
    func addNewMemo(newMemoTitleText: String, newMemoContentText: String, characterLimit: String, characterCount: Int, includeSpace: Bool, includeNewLine: Bool, removeEnclosedText: Bool, switchCountdown: Bool) {
        let newMemo = CountMemo(title: newMemoTitleText, content: newMemoContentText, date: "2023\n11/23", characterLimit: characterLimit, characterCount: characterCount, includeSpace: includeSpace, includeNewLine: includeNewLine, removeEnclosedText: removeEnclosedText, switchCountdown: switchCountdown)
        
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
    
    func modifiedTextCharacterCount(text: String, characterLimit: String, includeSpace: Bool, includeNewLine: Bool, removeEnclosedText: Bool, switchCountdown: Bool) -> Int {
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
        
        if switchCountdown {
            return((Int(characterLimit) ?? 0) - modifiedText.count)
        }
        
        return modifiedText.count
    }
}
