//
//  CountSettingView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/23.
//

import SwiftUI

struct CountSettingView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var includeSpace: Bool
    @Binding var includeNewLine: Bool
    @Binding var removeEnclosedText: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Toggle("空白をカウントする", isOn: $includeSpace)
                Toggle("改行をカウントする", isOn: $includeNewLine)
                Toggle("'//'で囲った文字をカウントしない", isOn: $removeEnclosedText)
            }
            .navigationTitle("カウント方式設定")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("OK")
                            .foregroundStyle(Color.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    CountSettingView(includeSpace: .constant(false), includeNewLine: .constant(false), removeEnclosedText: .constant(false))
}
