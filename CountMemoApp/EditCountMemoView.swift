//
//  EditCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/21.
//

import SwiftUI

struct EditCountMemoView: View {
    @State var memo: CountMemo
    @State var memoTitleText: String
    @State var memoContentText: String
    
    init(memo: CountMemo) {
        _memo = State(initialValue: memo)
        _memoTitleText = State(initialValue: memo.title)
        _memoContentText = State(initialValue: memo.content)
    }
    var body: some View {
        NavigationStack {
            VStack {
                TextField("タイトルを入力", text: $memoTitleText)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10.0)
                Divider()
                TextEditor(text: $memoContentText)
                    .padding(.horizontal, 10.0)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("計:\(memoContentText.count)")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    EditCountMemoView(memo: CountMemo(title: "タイトル", content: "内容", date: "2023\n11/21", characterCount: 1000))
}