//
//  CountMemoListRow.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import SwiftUI

struct CountMemoListRowView: View {
    @Binding var memo: CountMemo
    
    var body: some View {
        VStack {
            HStack{
                Text(memo.title)
                    .lineLimit(1)
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack {
                Text(memo.date)
                    .padding(.trailing, 10.0)
                HStack{
                    Text(memo.content)
                        .lineLimit(2)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.orisinal)
                    .frame(width: 70, height: 30)
                    .overlay(Text("\(memo.characterCount)"))
            }
        }
    }
}

#Preview {
    CountMemoListRowView(memo: .constant(CountMemo(title: "タイトル", content: "内容", date: "2023\n11/22", characterCount: 1000)))
}
