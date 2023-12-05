//
//  Memo.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import Foundation

struct CountMemo: Identifiable, Codable {
    var id = UUID()
    var title: String
    var content: String
    var date: String
    var characterCount: Int
    
    
    // 文字数を数える際に空白を含めるかどうかを切り替えるためのフラグ
    var includeSpace = false
    
    //改行を含めるかどうかを切り替えるフラグ
    var includeNewLine = false
    
    //'//'で囲った文字を含めるかどうかを切り替えるフラグ
    var removeEnclosedText = false
}
