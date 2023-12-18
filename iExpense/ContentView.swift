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

// A sheet is a new view presented on top of our existing one - gives us a card-like presentation where the currrent view slides away into the distance a little and the new view animates in on top
// Sheets work much like alerts in that we don't present them directly with code -> instead, we define the conditions under which a sheet should be shown and when those conditions become true or false the sheet will either be presented or dismissed, respectively

// onDelete()
// A modifier that controls how objects should be deleted from a collection
// Almost exclusively used with List and ForEach
// onDelete() modifier only exists on ForEach -> it is easier to create lists where only some rows can be deleted
// In order to make onDelete() work, you need to implement a method that will receive a single paramter of type IndexSet -> this is a bit like a set of integers except it is sorted and tells you the positions of all the items in the ForEach that should be removed
// Because the ForEach was created entirely from a single array, we can aactually just pass that index set straight to our numbers array - it has a special remove(atOffsets:) method that accepts an index set

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber =  1
    
    //    @State private var showingSheet = false
    //    @State private var user = User()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }

        //        Button("Show Sheet") {
        //            showingSheet.toggle()
        //        }
        //        .sheet(isPresented: $showingSheet) {
        //            SecondView(name: "Leo")
        //        }
        
        //        VStack {
        //            Text("Your name is \(user.firstName) \(user.lastName).")
        //            TextField("First name", text: $user.firstName)
        //            TextField("Last name", text: $user.lastName)
        //        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct SecondView: View {
    // To dismiss another view we need another property wrapper called @Environment - which allows you to create properties that store values provided to us externally
    // For example: user light mode vs. dark mode, smaller / larger fonts, and timezones
    // You can add a property called dismiss based on a value from the environment
    @Environment(\.dismiss) var dismiss
    let name: String

    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

#Preview {
    ContentView()
}
