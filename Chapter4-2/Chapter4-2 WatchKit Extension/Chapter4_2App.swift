import SwiftUI

// Main entry point for the Chapter4_2App application
@main
struct Chapter4_2App: App {
    // Define the body of the application scene
    @SceneBuilder var body: some Scene {
        // Main window group containing a navigation view with the SlideshowView
        WindowGroup {
            NavigationView {
                SlideshowView()
            }
        }

        // Notification scene for watchOS
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
