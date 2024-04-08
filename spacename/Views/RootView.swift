//
//  ContentView.swift
//  spacename
//
//  Created by Noor Ahmed on 04/04/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        ZStack {
            TabbarView()
        }
        .background(Color.black)
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
    }
}

#Preview {
    RootView()
}
