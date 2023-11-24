//
//  CountSettingView.swift
//  CountMemoApp
//
//  Created by 浜崎良 on 2023/11/23.
//

import SwiftUI

struct CountSettingView: View {
    @State var includeSpace = false
    @State var includeNewLine = false
    
    var body: some View {
        NavigationStack {
            List {
                VStack{
                    Toggle("空白をカウントする", isOn: $includeSpace)
                    Toggle("改行をカウントする", isOn: $includeNewLine)
                }
            }
        }
    }
}

#Preview {
    CountSettingView()
}
