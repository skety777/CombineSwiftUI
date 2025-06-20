# CombineSwiftUI
Modern SwiftUI networking with Combine &amp; URLSession. A lightweight, reactive solution for API calls with full error handling and SwiftUI integration.

# 🚀 Combine + SwiftUI Networking Layer

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange?logo=swift)](https://swift.org)
[![Platform](https://img.shields.io/badge/iOS-15%2B-blue)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-lightgrey)](LICENSE)

A modern networking solution using **Combine** and **SwiftUI**, featuring:

- ✅ Reactive API calls with `URLSession.dataTaskPublisher`
- ✅ Generic `NetworkManager` supporting any `Decodable` model
- ✅ Comprehensive error handling
- ✅ Loading state management
- ✅ Seamless SwiftUI integration

![Demo](https://github.com/yourusername/combine-swiftui-networking/raw/main/Demo.gif)

## 🛠 Installation

### Manual
1. Add these files to your project:
   - `NetworkManager.swift`
   - `APIError.swift`
   - `APIEndpoint.swift`

### Swift Package Manager
```swift
dependencies: [
    .package(url: "https://github.com/yourusername/combine-swiftui-networking.git", from: "1.0.0")
]

