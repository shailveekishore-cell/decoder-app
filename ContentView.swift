//
//  ContentView.swift
//  Decoder App
//
//  Created by shailvee kishore on 4/14/26.
//


import SwiftUI
import UIKit

struct ContentView: View {
    @State private var aiResponse = ""
    @State private var isLoading = false
    @State private var errorInput = ""
    @State private var selectedLanguage = "Swift"
    @State private var result: ErrorAnalysis?
    @State private var copiedMessage = ""

    let languages = ["Swift", "Python", "Java"]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.blue.opacity(0.18), .purple.opacity(0.14), .white],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Decoder App")
                                .font(.largeTitle)
                                .bold()

                            Text("Beginner-friendly code error explanations")
                                .foregroundStyle(.secondary)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Language")
                                .font(.headline)

                            Picker("Language", selection: $selectedLanguage) {
                                ForEach(languages, id: \.self) { language in
                                    Text(language)
                                }
                            }
                            .pickerStyle(.segmented)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Paste an error")
                                .font(.headline)

                            TextField("Example: Index out of range", text: $errorInput)
                                .padding()
                                .background(.white)
                                .cornerRadius(14)
                                .shadow(radius: 3)
                        }

                        Button(action: {
                            result = analyzeError(input: errorInput, language: selectedLanguage)
                            copiedMessage = ""
                        }) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                Text("Analyze Error")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                        }

                        if let result = result {
                            VStack(alignment: .leading, spacing: 14) {
                                HStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.orange)

                                    Text("Error Type: \(result.errorType)")
                                        .font(.headline)
                                }

                                Divider()

                                Text("Explanation")
                                    .font(.headline)
                                Text(result.logicExplanation)

                                Text("Fix Steps")
                                    .font(.headline)

                                ForEach(result.fixSteps, id: \.self) { step in
                                    Text("• \(step)")
                                }

                                Text("Code Example")
                                    .font(.headline)

                                Text(result.codeExample)
                                    .font(.system(.body, design: .monospaced))
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(.black.opacity(0.05))
                                    .cornerRadius(12)

                                Button(action: {
                                    copyResult(result)
                                }) {
                                    HStack {
                                        Image(systemName: "doc.on.doc")
                                        Text("Copy Result")
                                            .fontWeight(.semibold)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(14)
                                }

                                Button(action: {
                                    isLoading = true
                                    aiResponse = ""

                                    Task {
                                        do {
                                            let service = OpenAIService()
                                            let response = try await service.analyzeError(
                                                errorText: errorInput
                                            )

                                            await MainActor.run {
                                                aiResponse = response
                                                isLoading = false
                                            }
                                        } catch {
                                            await MainActor.run {
                                                aiResponse = "Failed to analyze error."
                                                isLoading = false
                                            }
                                        }
                                    }
                                }) {
                                    HStack {
                                        if isLoading {
                                            ProgressView()
                                                .tint(.white)
                                        } else {
                                            Image(systemName: "sparkles")
                                        }

                                        Text(isLoading ? "Analyzing..." : "Ask AI for More Help")
                                            .fontWeight(.semibold)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(.purple)
                                    .foregroundColor(.white)
                                    .cornerRadius(14)
                                }
                                .disabled(isLoading)

                                if !copiedMessage.isEmpty {
                                    Text(copiedMessage)
                                        .font(.subheadline)
                                        .foregroundStyle(.green)
                                }

                                if !aiResponse.isEmpty {
                                    Text("AI Explanation")
                                        .font(.headline)

                                    Text(aiResponse)
                                }
                            }
                            .padding()
                            .background(.white.opacity(0.92))
                            .cornerRadius(20)
                            .shadow(radius: 6)
                        } else if !errorInput.isEmpty {
                            Text("No matching error found yet for \(selectedLanguage).")
                                .foregroundStyle(.red)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Decoder")
        }
    }

    func copyResult(_ result: ErrorAnalysis) {
        let textToCopy = """
        Error Type: \(result.errorType)

        Explanation:
        \(result.logicExplanation)

        Fix Steps:
        \(result.fixSteps.joined(separator: "\n"))

        Code Example:
        \(result.codeExample)
        """

        UIPasteboard.general.string = textToCopy
        copiedMessage = "Copied to clipboard."
    }
}

#Preview {
    ContentView()
}
