//
//  CountMemoListView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import SwiftUI
import RealmSwift

struct CountMemoListView: View {
    @ObservedResults(CountMemo.self, configuration: Realm.Configuration(schemaVersion:1),sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var memos
    
    var body: some View {
        NavigationStack {
            List(memos) { memo in
                NavigationLink(destination: EditCountMemoView(memo: memo)) {
                    CountMemoListRow(memo: memo)
                        .swipeActions(edge: .trailing) {
                            Button{$memos.remove(memo)} label: {
                                Image(systemName: "trash")
                                    .tint(.red)
                            }
                        }
                }
            }            .navigationTitle("リスト")
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