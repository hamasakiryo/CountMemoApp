//
//  CountMemoListView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import SwiftUI

struct CountMemoListView: View {
    @ObservedObject var memoData: CountMemoData
    var body: some View {
        NavigationStack {
            List($memoData.memos) { $memo in
                NavigationLink(destination: EditCountMemoView(memoData:  memoData, memo: memo)) {
                    CountMemoListRowView(memo: $memo)
                }
            }
        }
    }
}


#Preview {
    CountMemoListView(memoData: CountMemoData())
}
