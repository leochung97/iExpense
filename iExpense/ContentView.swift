import SwiftUI
import Observation

// Structs have unique owners whereas classes multiple things can point to the same value
// Classes don't need the mutating keyword before methods that change thier properties because you can change properties of constant classes
// If you want to share data between multiple views - use classes rather than structs
// If you change User to a class instead, this will not work: Swift creates a new instance of the struct User when its properties are modified -> this will allow @State to observe the change and reload our view
// You can fix the above issue by using @Observable keyword to allow Swift to detect changes in the class properties and not just the class

// struct User {
//     var firstName = "Bilbo"
//     var lastName = "Baggins"
// }

// Note: you can to import Observation
// @Observable is a macro -> you can right click and expand macro to see what's happening
// iOS keeps track of every SwiftUI view that reads properties from an @Observed object, so when a property changes it can intelligently update all the views that depend on it while leaving the others unchanged
// When working with structs, @State property wrapper keeps a value alive and also watches it for changes
// On the other hand, when working with classes, @State is just there for keeping the object alive - all the watching for changes and updating the view is taken care of by @Observable
@Observable
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct ContentView: View {
    @State private var user = User()
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

#Preview {
    ContentView()
}
