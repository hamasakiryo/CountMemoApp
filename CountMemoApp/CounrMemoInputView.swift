//
//  CounrMemoInputView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/12/02.
//

import SwiftUI

struct CounrMemoInputView: View {
    @Environment (\.dismiss) private var dismiss
    @ObservedObject var countSetting = CountSetting()
    @Binding var memoTitleText: String
    @Binding var memoContentText: String
    @State var isShowCountSettingView = false
    
    var body: some View {
        VStack {
            Text("計:\(countSetting.modifiedTextCharacterCount(text: memoContentText))")
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
            CountSettingView(counrSetting: countSetting)
                .presentationDetents([.medium])
        }
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
}

#Preview {
    CounrMemoInputView(memoTitleText: .constant("タイトル"), memoContentText: .constant("内容"))
}
