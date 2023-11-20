//
//  Memo.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import SwiftUI

struct CountMemo: Identifiable {
    var id = UUID()
    var title: String
    var content: String
    var date: String
    var characterCount: Int
}
