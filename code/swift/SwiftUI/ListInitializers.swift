
// I could copy and paste this file's content to replace any new SwiftUI project's ContentView.swift


import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            SimpleListView()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct SimpleListView: View {
    var body: some View {
        List {
            Text("Appleseed")
            Text("Grapes")
            Text("Strawberry")
        }

    }
}

    
