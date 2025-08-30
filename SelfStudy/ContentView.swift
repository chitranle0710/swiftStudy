//
//  ContentView.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var count = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) { // like LinearLayout vertical
            Text("Count: \(count)")
            Button("Increase") { count += 1 }
            Text("Another text")
        }
        .frame(maxHeight: .infinity, alignment: .top) // pin to top
        .padding() // optional margin like in Android
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

