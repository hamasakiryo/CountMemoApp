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
                CountMemoListRowView()
            }
        }
    }
}

#Preview {
    CountMemoListView()
}
