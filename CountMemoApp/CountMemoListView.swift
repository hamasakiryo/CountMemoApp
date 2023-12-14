//
//  CountMemoListView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import SwiftUI
import RealmSwift

struct CountMemoListView: View {
    @ObservedResults(CountMemo.self, configuration: Realm.Configuration(schemaVersion: 2)) var memos
    
    var body: some View {
        NavigationStack {
            List(memos) { memo in
                NavigationLink(destination: EditCountMemoView(memo: memo)) {
                    CountMemoListRowView(memo: memo)
                }
            }
            .navigationTitle("リスト")
            .onAppear{
                //空のメモを削除する処理
            }
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink(destination: AddNewCountMemoView().environment(\.realm, try! .init(configuration: Realm.Configuration()))) {
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
