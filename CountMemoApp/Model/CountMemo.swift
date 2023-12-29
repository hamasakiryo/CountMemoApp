//
//  Memo.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import Foundation
import RealmSwift

class CountMemo: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var date = Date()
    @Persisted var characterLimit: String
    @Persisted var characterCount: Int
    @Persisted var includeSpace: Bool
    @Persisted var includeNewLine: Bool
    @Persisted var removeEnclosedText: Bool
    @Persisted var switchCountdown: Bool
}
