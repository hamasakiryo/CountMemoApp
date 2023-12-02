//
//  AddNewCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/22.
//

import SwiftUI

struct AddNewCountMemoView: View {
    @Environment (\.dismiss) private var dismiss
    @ObservedObject var memoData: CountMemoData
    @ObservedObject var countSetting: CountSetting
    @State var newMemoTitleText = ""
    @State var newMemoContentText = ""
    
    var body: some View {
        NavigationStack {
            CounrMemoInputView(memoTitleText: $newMemoTitleText, memoContentText: $newMemoContentText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("<リスト") {
                            addNewMemo()
                            dismiss()
                    }
                }
            }
        }
    }
    func addNewMemo() {
        let newMemo = CountMemo(title: newMemoTitleText, content: newMemoContentText, date: "2023\n11/23", characterCount: countSetting.modifiedTextCharacterCount(text: newMemoContentText))
        
        memoData.memos.insert(newMemo, at: 0)
        newMemoTitleText = ""
        newMemoContentText = ""
    }
}

#Preview {
    AddNewCountMemoView(memoData: CountMemoData(), countSetting: CountSetting())
}
