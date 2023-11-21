//
//  EditCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/21.
//

import SwiftUI

struct EditCountMemoView: View {
    @State var memoTitleText: String
    @State var memoContentText: String
    
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
    EditCountMemoView(memoTitleText: "タイトル1", memoContentText: "内容1")
}
