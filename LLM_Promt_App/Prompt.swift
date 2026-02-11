//
//  Prompt.swift
//  LLM_Promt_App
//
//  Created by Vishal Kothari on 11/02/26.
//

import Foundation


// Request model
struct LLMRequest: Codable {
    let prompt: String
    let model: String
}

// Response model
struct LLMResponse: Codable {
    let answer: String
}

func askBackend(question: String, completion: @escaping (String?) -> Void) {
    guard let url = URL(string: "http://127.0.0.1:8000/llm/ask") else {
        completion(nil)
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let body = LLMRequest(prompt: question, model:  "tinyllama",)
    request.httpBody = try? JSONEncoder().encode(body)

    let task = URLSession.shared.dataTask(with: request) { data,response,error in
        guard let data = data,error == nil else {
            completion(nil)
            return
        }

        if let response = try? JSONDecoder().decode(
                LLMResponse.self,
                from: data) {
            completion(response.answer)
        } else {
            completion(nil)
        }
    }
    task.resume()
}
