//
//  EditCountMemoView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/21.
//

import SwiftUI
import RealmSwift

struct EditCountMemoView: View {
    @Environment (\.dismiss) private var dismiss
    @ObservedRealmObject var memo: CountMemo
    @State var memoTitleText: String
    @State var memoContentText: String
    @State var characterLimit: String
    @State var characterCount: Int
    @State var includeSpace: Bool
    @State var includeNewLine: Bool
    @State var removeEnclosedText: Bool
    @State var switchCountdown: Bool
    @State var isShowCountSettingView = false
    
    init(memo: CountMemo) {
        self.memo = memo
        _memoTitleText = State(initialValue: memo.title)
        _memoContentText = State(initialValue: memo.content)
        _characterLimit = State(initialValue: memo.characterLimit)
        _characterCount = State(initialValue: memo.characterCount)
        _includeSpace = State(initialValue: memo.includeSpace)
        _includeNewLine = State(initialValue: memo.includeNewLine)
        _removeEnclosedText = State(initialValue: memo.removeEnclosedText)
        _switchCountdown = State(initialValue: memo.switchCountdown)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(switchCountdown ? "残:" : "計:")\(characterCount)")
                    .foregroundStyle(characterCount < 0 ? .red : .primary)
                    .font(.title)
                    .fontWeight(.bold)
                TextField("タイトルを入力", text: $memoTitleText)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10.0)
                Divider()
                TextEditor(text: $memoContentText)
                    .onChange(of: memoContentText) {
                        characterCount = modifiedTextCharacterCount(text: memoContentText, characterLimit: characterLimit,includeSpace: includeSpace, includeNewLine: includeNewLine, removeEnclosedText: removeEnclosedText, switchCountdown: switchCountdown)
                    }
                    .padding(.horizontal, 10.0)
            }
            .sheet(isPresented: $isShowCountSettingView) {
                CountSettingView(includeSpace: $includeSpace,
                                 includeNewLine: $includeNewLine,
                                 removeEnclosedText: $removeEnclosedText,
                                 switchCountDown: $switchCountdown, charcterLimit: $characterLimit
                )
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
                    let thawMemo = memo.thaw()
                    try! thawMemo?.realm!.write{
                        thawMemo?.title = memoTitleText
                        thawMemo?.content = memoContentText
                        thawMemo?.characterCount = characterCount
                        thawMemo?.characterLimit = characterLimit
                        thawMemo?.includeSpace = includeSpace
                        thawMemo?.includeNewLine = includeNewLine
                        thawMemo?.removeEnclosedText = removeEnclosedText
                        thawMemo?.switchCountdown = switchCountdown
                    }
                    dismiss()
                }
            }
        }
    }
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
#Preview {
    EditCountMemoView(memo: CountMemo())
}
