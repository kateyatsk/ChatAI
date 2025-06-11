//
//  ViewModel.swift
//  ChatAI
//
//  Created by Екатерина Яцкевич on 11.06.25.
//

import SwiftUI

class ViewModel: ObservableObject {
    private let manager = NetworkManager()
    @Published var text: String?
    
    func sendRequest(promt: String) {
        manager.generateText(promt: promt) { [weak self] req in
            if let text = req?.choices.first?.message.content  {
                DispatchQueue.main.async {
                    self?.text = text
                }
            }
        }
    }
    
}
