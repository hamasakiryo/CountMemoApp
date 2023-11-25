//
//  CountSettingView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/23.
//

import SwiftUI

struct CountSettingView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var countSettingVM: CountSettingViewModel
    var body: some View {
        NavigationStack {
            List {
                Toggle("空白をカウントする", isOn: $countSettingVM.includeSpace)
                Toggle("改行をカウントする", isOn: $countSettingVM.includeNewLine)
                Toggle("'//'で囲った文字をカウントしない", isOn: $countSettingVM.removeEnclosedText)
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
    CountSettingView(countSettingVM: CountSettingViewModel())
}
