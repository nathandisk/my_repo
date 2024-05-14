import SwiftUI // Importing the SwiftUI framework

struct NotificationView: View { // Defining a SwiftUI view called NotificationView
    var body: some View { // Declaring the body property of the view
        Text("Hello, World!") // Displaying a Text view with the message "Hello, World!"
    }
}

struct NotificationView_Previews: PreviewProvider { // Defining a preview provider for the NotificationView
    static var previews: some View { // Declaring a preview of the NotificationView
        NotificationView() // Displaying a preview of the NotificationView
    }
}
