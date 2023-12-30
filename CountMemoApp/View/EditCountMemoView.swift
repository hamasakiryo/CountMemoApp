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
    @State private var showCountSettingView = false
    var textCounter = TextCounter()
    
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
                            thawMemo?.characterCount = textCounter.modifiedTextCharacterCount(
                                text: memo.content,
                                characterLimit: memo.characterLimit,
                                includeSpace: memo.includeSpace,
                                includeNewLine: memo.includeNewLine,
                                removeEnclosedText: memo.removeEnclosedText,
                                switchCountdown: memo.switchCountdown)
                        }
                    }
                    .padding(.horizontal, 10.0)
            }
            .sheet(isPresented: $showCountSettingView) {
                CountSettingView(includeSpace: $memo.includeSpace,
                                 includeNewLine: $memo.includeNewLine,
                                 removeEnclosedText: $memo.removeEnclosedText,
                                 switchCountDown: $memo.switchCountdown,
                                 charcterLimit: $memo.characterLimit)
                .presentationDetents([.medium])
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        showCountSettingView = true
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
}
#Preview {
    EditCountMemoView(memo: CountMemo())
}
