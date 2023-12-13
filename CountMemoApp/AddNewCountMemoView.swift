//
//  AddNewCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/22.
//

import SwiftUI

struct AddNewCountMemoView: View {
    @Environment (\.dismiss) private var dismiss
    @ObservedObject var memoData: CountMemoManager
    @State var newMemoTitleText = ""
    @State var newMemoContentText = ""
    @State var characterLimit = ""
    @State var characterCount = 0
    @State var isShowCountSettingView = false
    @State var includeSpace = false
    @State var includeNewLine = false
    @State var removeEnclosedText = false
    @State var switchCountdown = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(switchCountdown ? "残:" : "計:")\(characterCount)")
                    .foregroundStyle(characterCount < 0 ? .red : .primary)
                    .font(.title)
                    .fontWeight(.bold)
                TextField("タイトルを入力", text: $newMemoTitleText)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10.0)
                Divider()
                TextEditor(text: $newMemoContentText)
                    .onChange(of: newMemoContentText) {
                        characterCount = memoData.modifiedTextCharacterCount(
                            text: newMemoContentText,
                            characterLimit: characterLimit,
                            includeSpace: includeSpace,
                            includeNewLine: includeNewLine,
                            removeEnclosedText: removeEnclosedText,
                            switchCountdown: switchCountdown)
                    }
                    .padding(.horizontal, 10.0)
            }
            .sheet(isPresented: $isShowCountSettingView) {
                CountSettingView(includeSpace: $includeSpace, includeNewLine: $includeNewLine, removeEnclosedText: $removeEnclosedText, switchCountDown: $switchCountdown, charcterLimit: $characterLimit)
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("<リスト") {
                        memoData.addNewMemo(newMemoTitleText: newMemoTitleText,
                                            newMemoContentText: newMemoContentText, characterLimit: characterLimit,
                                            characterCount: characterCount,
                                            includeSpace: includeSpace,
                                            includeNewLine: includeNewLine,
                                            removeEnclosedText: removeEnclosedText,
                                            switchCountdown: switchCountdown
                        )
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddNewCountMemoView(memoData: CountMemoManager())
}
