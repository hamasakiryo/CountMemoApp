//
//  EditCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/21.
//

import SwiftUI

struct EditCountMemoView: View {
    @State var MemoTitleText: String
    @State var MemoContentText: String
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("タイトルを入力", text: $MemoTitleText)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10.0)
                Divider()
                TextEditor(text: $MemoContentText)
                    .padding(.horizontal, 10.0)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("計:\(MemoContentText.count)")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    EditCountMemoView(MemoTitleText: "タイトル1", MemoContentText: "内容1")
}
