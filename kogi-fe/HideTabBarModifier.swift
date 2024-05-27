import SwiftUI

struct HideTabBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        content
            .onAppear {
                self.setTabBar(hidden: true)
            }
            .onDisappear {
                self.setTabBar(hidden: false)
            }
    }

    private func setTabBar(hidden: Bool) {
        guard let window = UIApplication.shared.windows.first,
              let tabBarController = window.rootViewController as? UITabBarController else { return }
        tabBarController.tabBar.isHidden = hidden
    }
}

extension View {
    func hideTabBar() -> some View {
        self.modifier(HideTabBarModifier())
    }
}
