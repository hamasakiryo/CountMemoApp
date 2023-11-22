//
//  AddNewCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/22.
//

import SwiftUI

struct AddNewCountMemoView: View {
    @Environment (\.dismiss) private var dismiss
    @State var newMemoTitleText = ""
    @State var newMemoContentText = ""
    var body: some View {
        NavigationStack {
            VStack {
                TextField("タイトルを入力", text: $newMemoTitleText)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10.0)
                Divider()
                TextEditor(text: $newMemoContentText)
                    .padding(.horizontal, 10.0)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("計:\(newMemoContentText.count)")
                        .font(.title)
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("<リスト") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddNewCountMemoView()
}
