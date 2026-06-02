//
//  OpenAIService.swift
//  Decoder App
//
//  Created by shailvee kishore on 5/13/26.
//

import Foundation

class OpenAIService {

    let apiKey = "PASTE_YOUR_API_KEY_HERE"

    func analyzeError(errorText: String) async throws -> String {

        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            return "Invalid URL"
        }

        let prompt = """
        Explain this coding error in beginner-friendly language.
        Include:
        1. What the error means
        2. Why it happens
        3. How to fix it
        4. A simple code example

        Error:
        \(errorText)
        """

        let body: [String: Any] = [
            "model": "gpt-4.1-mini",
            "messages": [
                [
                    "role": "user",
                    "content": prompt
                ]
            ],
            "temperature": 0.7
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)

        let response = try JSONDecoder().decode(OpenAIResponse.self, from: data)

        return response.choices.first?.message.content ?? "No response"
    }
}

struct OpenAIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let content: String
}
