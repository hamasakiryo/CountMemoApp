//
//  EditCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/21.
//

import SwiftUI

struct EditCountMemoView: View {
    @Environment (\.dismiss) private var dismiss
    var memo: CountMemo
    @ObservedObject var memoData: CountMemoData
    @State var memoTitleText: String
    @State var memoContentText: String
    @State var isShowCountSettingView = false
    
    init(memoData: CountMemoData,memo: CountMemo) {
        self.memo = memo
        _memoData = ObservedObject(wrappedValue: memoData)
        _memoTitleText = State(initialValue: memo.title)
        _memoContentText = State(initialValue: memo.content)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("計:\(memoData.modifiedTextCharacterCount(text: memoContentText))")
                    .font(.title)
                    .fontWeight(.bold)
                TextField("タイトルを入力", text: $memoTitleText)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10.0)
                Divider()
                TextEditor(text: $memoContentText)
                    .padding(.horizontal, 10.0)
            }
            .sheet(isPresented: $isShowCountSettingView) {
                CountSettingView(memoData: memoData)
                    .presentationDetents([.medium])
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                
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
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("<リスト") {
                            memoData.saveMemo(memo: memo,
                                              memoTitleText: memoTitleText,
                                              memoContentText: memoContentText,
                                              characterCount: memoData.modifiedTextCharacterCount(text: memoContentText))
                        dismiss()
                    }
                }
            }
        }
    }


#Preview {
    EditCountMemoView(memoData: CountMemoData(), memo: CountMemo(title: "タイトル", content: "内容", date: "2023\n11/21", characterCount: 1000))
}
