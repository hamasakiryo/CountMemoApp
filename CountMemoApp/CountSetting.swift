//
//  CountSettingViewModel.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/23.
//

import SwiftUI

class CountSetting: ObservableObject {
    // 文字数を数える際に空白を含めるかどうかを切り替えるためのフラグ
    @Published var includeSpace = false
    
    //改行を含めるかどうかを切り替えるフラグ
    @Published var includeNewLine = false
    
    //'//'で囲った文字を含めるかどうかを切り替えるフラグ
    @Published var removeEnclosedText = false
    
    // 修正されたテキストの文字数をカウントする関数
    func modifiedTextCharacterCount(text: String) -> Int {
        var modifiedText = text
        
        // includeSpaceがfalseの場合、テキストから空白を除去(デフォルトで文字数のカウントには空白が含まれない)
        if !includeSpace {
            modifiedText = modifiedText.replacingOccurrences(of: " 　", with: "", options: .regularExpression)
        }
        
        //includeNewLineがfalseの場合、テキストから改行を除去(デフォルトで文字数のカウントには改行が含まれない)
        if !includeNewLine {
            modifiedText = modifiedText.replacingOccurrences(of: "\n", with: "")
        }
        
        //removeEnclosedTextがtrueの場合、テキストから'//'で囲まれた文字を除去(例: //文字// とすると「文字」が除去される)
        if removeEnclosedText {
            modifiedText = modifiedText.replacingOccurrences(of: "//(.*?)//", with: "")
        }
        
        return modifiedText.count
    }
}
