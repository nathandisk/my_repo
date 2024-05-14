import SwiftUI

@main
struct Chapter4_2App: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                SlideshowView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
