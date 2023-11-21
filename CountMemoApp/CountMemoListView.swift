//
//  CountMemoListView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import SwiftUI

struct CountMemoListView: View {
    @State var memos: [CountMemo] = [
        CountMemo(title: "タイトル1", content: "内容1", date: "2023\n11/21", characterCount: 1000),
        CountMemo(title: "タイトル2", content: "内容2", date: "2023\n11/22", characterCount: 2000)
    ]
    
    var body: some View {
        NavigationStack {
            List(memos) { memo in
                NavigationLink(destination: EditCountMemoView(memo: memo)) {
                    CountMemoListRowView(memo: memo)
                        .foregroundStyle(Color.primary)
                }
            }
        }
    }
}


#Preview {
    CountMemoListView()
}
