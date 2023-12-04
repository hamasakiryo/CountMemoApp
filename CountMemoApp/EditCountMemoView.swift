//
//  EditCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/21.
//

import SwiftUI

struct EditCountMemoView: View {
    @Environment (\.dismiss) private var dismiss
    var memo: CountMemo
    @ObservedObject var memoData: CountMemoData
    @ObservedObject var countSetting: CountSetting
    @State var memoTitleText: String
    @State var memoContentText: String
    
    init(memoData: CountMemoData,memo: CountMemo, countSetting: CountSetting) {
        self.memo = memo
        _countSetting = ObservedObject(initialValue: countSetting)
        _memoData = ObservedObject(wrappedValue: memoData)
        _memoTitleText = State(initialValue: memo.title)
        _memoContentText = State(initialValue: memo.content)
    }
    
    var body: some View {
        NavigationStack {
            CountMemoInputView(memoTitleText: $memoTitleText, memoContentText: $memoContentText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("<リスト") {
                            saveMemo()
                            dismiss()
                    }
                }
            }
        }
    }
    func saveMemo() {
        if let index = memoData.memos.firstIndex(where: { $0.id == memo.id }) {
            memoData.memos[index].title = memoTitleText
            memoData.memos[index].content = memoContentText
            memoData.memos[index].characterCount = countSetting.modifiedTextCharacterCount(text: memoContentText)
        }
    }
}

#Preview {
    EditCountMemoView(memoData: CountMemoData(), memo: CountMemo(title: "タイトル", content: "内容", date: "2023\n11/21", characterCount: 1000), countSetting: CountSetting())
}
