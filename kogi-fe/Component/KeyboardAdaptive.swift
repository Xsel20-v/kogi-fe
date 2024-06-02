//
//  KeyboardAdaptive.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 28/05/24.
//

import SwiftUI
import Combine

import SwiftUI
import Combine

class KeyboardObserver: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification in
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .map { rect in
                rect.height
            }
            .map { height in
                height == UIScreen.main.bounds.height ? 0 : height
            }
            .sink { [weak self] height in
                self?.keyboardHeight = height
            }
            .store(in: &cancellableSet)
    }
}
