//
//  CountMemoListRow.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/20.
//

import SwiftUI

struct CountMemoListRow: View {
    let memo: CountMemo
    
    var body: some View {
        VStack {
            Text(memo.title)
                .lineLimit(1)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text(memo.date.formatted(date: .numeric, time: .omitted))
                    .padding(.trailing, 10.0)
                Text(memo.content)
                    .lineLimit(2)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.orisinal)
                    .frame(width: 70, height: 30)
                    .overlay(Text("\(memo.characterCount)"))
            }
        }
    }
}

#Preview {
    CountMemoListRow(memo: CountMemo())
}
