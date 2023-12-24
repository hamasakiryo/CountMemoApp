//
//  AddNewCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/22.
//

import SwiftUI
import RealmSwift

struct AddNewCountMemoView: View {
    @ObservedResults(CountMemo.self) var memos
    @Environment (\.dismiss) private var dismiss
    @State private var newMemoTitleText = ""
    @State private var newMemoContentText = ""
    @State private var characterLimit = ""
    @State private var characterCount = 0
    @State private var isShowCountSettingView = false
    @State private var includeSpace = false
    @State private var includeNewLine = false
    @State private var removeEnclosedText = false
    @State private var switchCountdown = false
    var textCounter = TextCounter()
    
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
                        characterCount = textCounter.modifiedTextCharacterCount(
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
                        //Realmに新しいメモを保存
                        let newMemo = CountMemo()
                        newMemo.title = newMemoTitleText
                        newMemo.content = newMemoContentText
                        newMemo.characterCount = characterCount
                        newMemo.characterLimit = characterLimit
                        newMemo.includeSpace = includeSpace
                        newMemo.includeNewLine = includeNewLine
                        newMemo.removeEnclosedText = removeEnclosedText
                        newMemo.switchCountdown = switchCountdown
                        $memos.append(newMemo)
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
