//
//  CountMemoListRow.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import SwiftUI

struct CountMemoListRow: View {
    var body: some View {
        VStack {
            HStack{
                Text("タイトル")
                    .lineLimit(1)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                Text("2023\n11/23")
                    .padding(.trailing, 10.0)
                Spacer()
                HStack{
                    Text("内容")
                        .lineLimit(2)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.orisinal)
                    .frame(width: 70, height: 30)
                    .overlay(Text("1000")
                        .foregroundStyle(.primary))
            }
        }
    }
}

#Preview {
    CountMemoListRow()
}
