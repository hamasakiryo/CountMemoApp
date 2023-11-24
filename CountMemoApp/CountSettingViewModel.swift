//
//  CountSettingViewModel.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/23.
//

import SwiftUI

class CountSettingViewModel: ObservableObject {
    // 文字数を数える際に空白を含めるかどうかを切り替えるためのフラグ
    @Published var includeSpace = false
    //改行を含めるかどうかを切り替えるフラグ
    @Published var includeNewLine = false
    
    // 修正されたテキストの文字数をカウントする関数
    func countCharacters(text: String) -> Int {
        var modifiedText = text
        
        // includeSpaceがfalseの場合、テキストから空白を除外(デフォルトで文字数のカウントには空白が含まれない)
        if !includeSpace {
            modifiedText = modifiedText.replacingOccurrences(of: " 　", with: "", options: .regularExpression)
        }
        
        //includeNewLineがfalseの場合、テキストから改行を除外(デフォルトで文字数のカウントには改行が含まれない)
        if !includeNewLine {
            modifiedText = modifiedText.replacingOccurrences(of: "\n", with: "")
        }
        
        return modifiedText.count
    }
}
