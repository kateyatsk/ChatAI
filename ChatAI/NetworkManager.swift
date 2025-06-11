//
//  NetworkManager.swift
//  ChatAI
//
//  Created by Екатерина Яцкевич on 10.06.25.
//
import SwiftUI

class NetworkManager {
    private let url = "https://bothub.chat/api/v2/openai/v1/chat/completions"
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI0LTc1NmUtNDVlOC04YWYxLTFlMWNkMDRkMDE1NyIsImlzRGV2ZWxvcGVyIjp0cnVlLCJpYXQiOjE3NDkyMjQ0OTcsImV4cCI6MjA2NDgwMDQ5N30.6oJIsJLpVouNG4sPmWBAwLjopZ5JdDP7RCVGde9I1t0"
    
    func generateText(promt: String, completion: @escaping (Requests?) -> Void) {
    
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let messages = [Message(role: "user", content: promt) ]
        let bodyRequest = ApiRequest(messages: messages)
        let httpBody = try? JSONEncoder().encode(bodyRequest)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            guard let data else {
                print(URLError.dataNotAllowed)
                return
            }
            
            print("Размер ответа в байтах: \(data.count)")
            print(String(data: data, encoding: .utf8) ?? "Не удалось преобразовать в строку")
            
            do {
                let decoded = try JSONDecoder().decode(Requests.self, from: data)
                completion(decoded)
            } catch {
                print("Ошибка декодирования: \(error.localizedDescription)")
                completion(nil)
            }
            
        }.resume()
    }
}

struct ApiRequest: Codable {
    var model: String = "gpt-4.1"
    var messages: [Message]
    var max_tokens: Int = 300
}

struct Message: Codable {
    let role: String
    var content: String
}

struct Requests: Decodable {
    let choices: [Choice]
}

struct Choice: Decodable {
    let message: MessageResponse
}

struct MessageResponse: Decodable {
    let content: String
}
