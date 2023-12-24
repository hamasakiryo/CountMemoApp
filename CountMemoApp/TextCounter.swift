//
//  TextCounter.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/12/24.
//

import SwiftUI

struct TextCounter {
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
