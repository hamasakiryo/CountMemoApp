//
//  CountMemoListView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import SwiftUI

struct CountMemoListView: View {
    @ObservedObject var memoData = CountMemoManager()
    
    var body: some View {
        NavigationStack {
            List(memoData.memos) { memo in
                NavigationLink(destination: EditCountMemoView(memoData: memoData, memo: memo)) {
                    CountMemoListRowView(memo: memo)
                }
            }
            .navigationTitle("リスト")
            .onAppear{
                memoData.removeEmptyMemo()
            }
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink(destination: AddNewCountMemoView(memoData: memoData)) {
                            Image(systemName: "square.and.pencil")
                    }
                    .foregroundStyle(.primary)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}


#Preview {
    CountMemoListView()
}
