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
            CountMemoInputView(memoTitleText: $newMemoTitleText, memoContentText: $newMemoContentText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("<リスト") {
                            memoData.addNewMemo(newMemoTitleText: newMemoTitleText,
                                                newMemoContentText: newMemoContentText,
                                                characterCount: countSetting.modifiedTextCharacterCount(text: newMemoContentText))
                            dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddNewCountMemoView(memoData: CountMemoData(), countSetting: CountSetting())
}
