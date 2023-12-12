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
    @ObservedObject var memoData: CountMemoManager
    @State var memoTitleText: String
    @State var memoContentText: String
    @State var characterLimit: String
    @State var includeSpace: Bool
    @State var includeNewLine: Bool
    @State var removeEnclosedText: Bool
    @State var switchCountdown: Bool
    @State var isShowCountSettingView = false
    
    init(memoData: CountMemoManager,memo: CountMemo) {
        self.memo = memo
        _memoData = ObservedObject(wrappedValue: memoData)
        _memoTitleText = State(initialValue: memo.title)
        _memoContentText = State(initialValue: memo.content)
        _characterLimit = State(initialValue: memo.characterLimit)
        _includeSpace = State(initialValue: memo.includeSpace)
        _includeNewLine = State(initialValue: memo.includeNewLine)
        _removeEnclosedText = State(initialValue: memo.removeEnclosedText)
        _switchCountdown = State(initialValue: memo.switchCountdown)
    }
    
    var body: some View {
        let characterCount = memoData.modifiedTextCharacterCount(text: memoContentText, characterLimit: characterLimit,includeSpace: includeSpace, includeNewLine: includeNewLine, removeEnclosedText: removeEnclosedText, switchCountdown: switchCountdown)
        
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
                    memoData.saveEditMemo(memo: memo,
                                      memoTitleText: memoTitleText,
                                      memoContentText: memoContentText,
                                      characterCount: characterCount,
                                      includeSpace: includeSpace,
                                      includeNewLine: includeNewLine,
                                      removeEnclosedText: removeEnclosedText,
                                      switchCountdown: switchCountdown)
                    dismiss()
                }
            }
        }
    }
}


#Preview {
    EditCountMemoView(memoData: CountMemoManager(), memo: CountMemo(title: "タイトル", content: "内容", characterLimit: "300", characterCount: 1000, includeSpace: false, includeNewLine: false, removeEnclosedText: false, switchCountdown: false))
}
