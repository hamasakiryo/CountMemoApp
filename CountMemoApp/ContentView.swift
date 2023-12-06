//
//  ContentView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CountMemoListView(memoData: CountMemoManager())
    }
}

#Preview {
    ContentView()
}
