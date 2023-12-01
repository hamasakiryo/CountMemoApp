//
//  CountSettingView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/23.
//

import SwiftUI

struct CountSettingView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var counrSetting: CountSetting
    
    var body: some View {
        NavigationStack {
            List {
                Toggle("空白をカウントする", isOn: $counrSetting.includeSpace)
                Toggle("改行をカウントする", isOn: $counrSetting.includeNewLine)
                Toggle("'//'で囲った文字をカウントしない", isOn: $counrSetting.removeEnclosedText)
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
    CountSettingView(counrSetting: CountSetting())
}
