//
//  SecureViewHostingViewController.swift
//  Screenshot Prevention
//
//  Created by Marius Preikschat on 24.05.25.
//

import SwiftUI

final class SecureViewHostingViewController<Content: View>: UIViewController {

    private let content: () -> Content
    
    private let secureView = ScreenshotPreventingView()

    var preventScreenCapture: Bool = true {
        didSet {
            secureView.preventScreenCapture = preventScreenCapture
        }
    }

    init(preventScreenCapture: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.preventScreenCapture = preventScreenCapture
        self.content = content
        super.init(nibName: nil, bundle: nil)

        setupUI()
        secureView.preventScreenCapture = preventScreenCapture
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        view.addSubview(secureView)
        secureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secureView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secureView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secureView.topAnchor.constraint(equalTo: view.topAnchor),
            secureView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let hostVC = UIHostingController(rootView: content())
        hostVC.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(hostVC)
        secureView.setup(contentView: hostVC.view)
        hostVC.didMove(toParent: self)
    }
}

public struct PreventScreenshot: ViewModifier {
    public let isProtected: Bool
    
    public func body(content: Content) -> some View {
        SecureView(preventScreenCapture: isProtected) {
            content
        }
    }
}

public extension View {
    func screenshotProtected(isProtected: Bool) -> some View {
        modifier(PreventScreenshot(isProtected: isProtected))
    }
}
