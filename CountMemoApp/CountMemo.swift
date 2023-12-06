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
    var characterLimit: String
    var characterCount: Int
    var includeSpace: Bool
    var includeNewLine: Bool
    var removeEnclosedText: Bool
    var switchCountdown: Bool
}
