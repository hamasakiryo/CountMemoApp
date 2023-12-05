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
    @State var includeSpace = false
    @State var includeNewLine = false
    @State var removeEnclosedText = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("計:\(memoData.modifiedTextCharacterCount(text: newMemoContentText, includeSpace: includeSpace, includeNewLine: includeNewLine, removeEnclosedText: removeEnclosedText))")
                .font(.title)
                .fontWeight(.bold)
            TextField("タイトルを入力", text: $newMemoTitleText)
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading, 10.0)
            Divider()
            TextEditor(text: $newMemoContentText)
                .padding(.horizontal, 10.0)
        }
        .sheet(isPresented: $isShowCountSettingView) {
            CountSettingView(includeSpace: $includeSpace, includeNewLine: $includeNewLine, removeEnclosedText: $removeEnclosedText)
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
                            memoData.addNewMemo(newMemoTitleText: newMemoTitleText,
                                                newMemoContentText: newMemoContentText,
                                                characterCount: memoData.modifiedTextCharacterCount(
                                                    text: newMemoContentText,
                                                    includeSpace: includeSpace,
                                                    includeNewLine: includeNewLine,
                                                    removeEnclosedText: removeEnclosedText
                                                ),
                                                includeSpace: includeSpace, 
                                                includeNewLine: includeNewLine,
                                                removeEnclosedText: removeEnclosedText
                                                )
                            dismiss()
                    }
                }
            }
        }
    }


#Preview {
    AddNewCountMemoView(memoData: CountMemoData())
}
