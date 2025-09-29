//
//  HomeView.swift
//  Joke
//
//  Created by Robin Kanatzar on 9/24/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                NavigationLink {
                    Example1View()
                } label: {
                    Text("Example 1: Utterance")
                }
                NavigationLink {
                    Example2View()
                } label: {
                    Text("Example 2: Utterance \"Knock Knock\"")
                }
                NavigationLink {
                    Example3View()
                } label: {
                    Text("Example 3: .duckOthers")
                }
                NavigationLink {
                    Example4View()
                } label: {
                    Text("Example 4: .mixWithOthers")
                }
                NavigationLink {
                    Example5View()
                } label: {
                    Text("Example 5")
                }
            }
        }
    }
}
