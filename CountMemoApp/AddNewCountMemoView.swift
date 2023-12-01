//
//  AddNewCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/22.
//

import SwiftUI

struct AddNewCountMemoView: View {
    @Environment (\.dismiss) private var dismiss
    @ObservedObject var memoData: CountMemoData
    @State var newMemoTitleText = ""
    @State var newMemoContentText = ""
    @State var isShowCountSettingView = false
    
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
            .sheet(isPresented: $isShowCountSettingView) {
                CountSettingView(counrSetting: CountSetting())
                    .presentationDetents([.medium])
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("<リスト") {
                        addNewMemo()
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("計:\(newMemoContentText.count)")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        isShowCountSettingView = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color.primary)
                            .font(.title)
                    }
                }
            }
        }
    }
    func addNewMemo() {
        let newMemo = CountMemo(title: newMemoTitleText, content: newMemoContentText, date: "2023\n11/23", characterCount: newMemoContentText.count)
        
        memoData.memos.insert(newMemo, at: 0)
        newMemoTitleText = ""
        newMemoContentText = ""
    }
}

#Preview {
    AddNewCountMemoView(memoData: CountMemoData())
}
