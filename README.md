# Decoder App 

Decoder is a native iOS application built using Swift and SwiftUI. It is designed to bridge the gap for beginner programmers by translating complex, cryptic compiler syntax errors into clear, actionable, and beginner-friendly explanations. 

## Features
- **Multi-Language Support:** Easily toggle between Swift, Python, and Java error styles.
- **Clean UI/UX:** Built with a modern, minimalist dark/light responsive interface utilizing SwiftUI gradients and intuitive user controls.
- **Error Breakdown:** Dedicated inputs allowing users to paste full error logs to receive immediate contextual clarity.

## 🛠️ Tech Stack & Architecture
- **Language:** Swift 5
- **Framework:** SwiftUI & UIKit
- **IDE:** Xcode
- **Architecture:** Modular Swift files including custom error analysis routing (`ErrorAnalyzer.swift`) and upcoming external service integrations (`OpenAIService.swift`).

  

##  Future Roadmap
- Implement automated API endpoints using the `OpenAIService` module to parse errors in real-time using AI models.
- Add an expanded offline database of common regional university Computer Science 101 error codes.
