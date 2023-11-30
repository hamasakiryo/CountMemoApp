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
            List(memoData.memos) { memo in
                NavigationLink(destination: EditCountMemoView(memoData:  memoData, memo: memo)) {
                    CountMemoListRowView(memo: memo)
                }
            }
            .navigationTitle("リスト")
            .onAppear{
                guard !memoData.memos.isEmpty else {
                    return
                }
                
                if memoData.memos[0].title.isEmpty && memoData.memos[0].content.isEmpty {
                    memoData.memos.remove(at: 0)
                }
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
    CountMemoListView(memoData: CountMemoData())
}
