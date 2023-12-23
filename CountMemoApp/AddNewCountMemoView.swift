//
//  AddNewCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/22.
//

import SwiftUI
import RealmSwift
struct TextCounter {
    
    ///条件に応じてtextを修正し、その文字数を返すメソッド(EditCountMemoView,AddNewCountMemoViewで使用)
    func modifiedTextCharacterCount(text: String, characterLimit: String, includeSpace: Bool, includeNewLine: Bool, removeEnclosedText: Bool, switchCountdown: Bool) -> Int {
        var modifiedText = text
        
        //includeSpaceがfalseの場合、テキストから空白を除去(デフォルトで文字数のカウントには空白が含まれない)
        if !includeSpace {
            modifiedText = modifiedText.replacingOccurrences(of: "[ 　]", with: "", options: .regularExpression)
        }
        //includeNewLineがfalseの場合、テキストから改行を除去(デフォルトで文字数のカウントには改行が含まれない)
        if !includeNewLine {
            modifiedText = modifiedText.replacingOccurrences(of: "\n", with: "")
        }
        
        //removeEnclosedTextがtrueの場合、テキストから'//'で囲まれた文字を除去(例: //文字// とすると「文字」が除去される)
        if removeEnclosedText {
            modifiedText = modifiedText.replacingOccurrences(of: "//(.*?)//", with: "", options: .regularExpression)
        }
        
        //カウントダウン方式に変更
        if switchCountdown {
            return((Int(characterLimit) ?? 0) - modifiedText.count)
        }
        
        return modifiedText.count
    }
}

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
