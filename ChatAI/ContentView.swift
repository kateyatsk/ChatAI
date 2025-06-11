//
//  ContentView.swift
//  ChatAI
//
//  Created by Екатерина Яцкевич on 10.06.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var text: String = ""
    
    var body: some View {
        VStack {
            TextField(text: $text) {
                Text("Введите запрос")
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack {
                Image(.robot)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                Spacer()
                Text(viewModel.text ?? "")
                    .frame(alignment: .leading)
            }
            .padding()
            .background(Color(.systemGray4))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button {
                viewModel.sendRequest(promt: text)
            } label: {
                Text("Спросить")
            }
            .padding()
            .background(.green)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding()
    }
        
}

#Preview {
    ContentView()
}
