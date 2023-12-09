//
//  CountMemoData.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/22.
//

import SwiftUI

class CountMemoManager: ObservableObject {
    
    @Published var memos: [CountMemo] = []
    
    ///既存のメモを編集し、更新するメソッド（EditCountMemoViewで使用）
    func saveEditMemo(memo: CountMemo, memoTitleText: String, memoContentText: String, characterCount: Int,includeSpace: Bool, includeNewLine: Bool, removeEnclosedText: Bool, switchCountdown: Bool) {
    //与えられたメモのidと配列内のメモのidが一致するか確認し、一致すればメモのインデックスをindexに代入
    if let index = memos.firstIndex(where: { $0.id == memo.id }) {
        //引数に与えられた情報を既存のメモの情報と変更
        memos[index].title = memoTitleText
        memos[index].content = memoContentText
        memos[index].characterCount = characterCount
        memos[index].includeSpace = includeSpace
        memos[index].includeNewLine = includeNewLine
        memos[index].removeEnclosedText = removeEnclosedText
        memos[index].switchCountdown = switchCountdown
        //既存のメモを削除して編集したメモを0番目に追加
        let editedmemo = memos.remove(at: index)
        memos.insert(editedmemo, at: 0)
        }
    }
    
    ///新しいメモを作成し、配列に追加するメソッド(AddNewCountMemoViewで使用)
    func addNewMemo(newMemoTitleText: String, newMemoContentText: String, characterLimit: String, characterCount: Int, includeSpace: Bool, includeNewLine: Bool, removeEnclosedText: Bool, switchCountdown: Bool) {
        //引数に与えられた情報をCountMemoに渡して新しいメモを作成
        let newMemo = CountMemo(title: newMemoTitleText, content: newMemoContentText, date: "2023\n11/23", characterLimit: characterLimit, characterCount: characterCount, includeSpace: includeSpace, includeNewLine: includeNewLine, removeEnclosedText: removeEnclosedText, switchCountdown: switchCountdown)
        //配列に追加
        memos.insert(newMemo, at: 0)
    }
    
    ///タイトルと内容が空のメモを削除するメソッド(CountMemoListViewで使用)
    func removeEmptyMemo() {
        //guard文で配列が空でないかを確認し、空であれば処理を抜ける
        guard !memos.isEmpty else {
            return
        }
        //追加、編集されたメモのtitle,contentが空か確認し、空であれば配列からそのメモを削除
        if memos[0].title.isEmpty && memos[0].content.isEmpty {
           memos.remove(at: 0)
        }
    }
    
    ///条件に応じてtextを修正し、その文字数を返すメソッド(EditCountMemoView,AddNewCountMemoViewで使用)
    func modifiedTextCharacterCount(text: String, characterLimit: String, includeSpace: Bool, includeNewLine: Bool, removeEnclosedText: Bool, switchCountdown: Bool) -> Int {
        var modifiedText = text
        
        //includeSpaceがfalseの場合、テキストから空白を除去(デフォルトで文字数のカウントには空白が含まれない)
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
        
        //カウントダウン方式に変更
        if switchCountdown {
            return((Int(characterLimit) ?? 0) - modifiedText.count)
        }
        
        return modifiedText.count
    }
}
