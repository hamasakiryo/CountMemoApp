//
//  CountMemoListView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import SwiftUI

struct CountMemoListView: View {
    var body: some View {
        NavigationStack {
            List {
                CountMemoListRowView(memo: CountMemo(title: "タイトル", content: "内容", date: "2023\n11/21", characterCount: 1000))
            }
        }
    }
}

#Preview {
    CountMemoListView()
}
