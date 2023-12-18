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
    @State private var isShowCountSettingView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(memo.switchCountdown ? "残:" : "計:")\(memo.characterCount)")
                    .foregroundStyle(memo.characterCount < 0 ? .red : .primary)
                    .font(.title)
                    .fontWeight(.bold)
                TextField("タイトルを入力", text: $memo.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10.0)
                Divider()
                TextEditor(text: $memo.content)
                    .onChange(of: memo.content) {
                        let thawMemo = memo.thaw()
                        try! thawMemo?.realm?.write{
                            thawMemo?.characterCount = modifiedTextCharacterCount(text: memo.content, characterLimit: memo.characterLimit,includeSpace: memo.includeSpace, includeNewLine: memo.includeNewLine, removeEnclosedText: memo.removeEnclosedText, switchCountdown: memo.switchCountdown)
                        }
                    }
                    .padding(.horizontal, 10.0)
            }
            .sheet(isPresented: $isShowCountSettingView) {
                CountSettingView(includeSpace: $memo.includeSpace,
                                 includeNewLine: $memo.includeNewLine,
                                 removeEnclosedText: $memo.removeEnclosedText,
                                 switchCountDown: $memo.switchCountdown, charcterLimit: $memo.characterLimit
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
