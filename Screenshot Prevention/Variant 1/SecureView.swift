//
//  SecureView.swift
//  Screenshot Prevention
//
//  Created by Marius Preikschat on 24.05.25.
//

import SwiftUI
import UIKit

struct SecureView<Content: View>: UIViewControllerRepresentable {

    private var preventScreenCapture: Bool
    private let content: () -> Content

    init(preventScreenCapture: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.preventScreenCapture = preventScreenCapture
        self.content = content
    }

    func makeUIViewController(context: Context) -> SecureViewHostingViewController<Content> {
        SecureViewHostingViewController(preventScreenCapture: preventScreenCapture, content: content)
    }

    func updateUIViewController(_ uiViewController: SecureViewHostingViewController<Content>, context: Context) {
        uiViewController.preventScreenCapture = preventScreenCapture
    }
}
