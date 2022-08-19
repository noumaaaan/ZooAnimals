//
//  animalsApp.swift
//  animals
//
//  Created by Nouman Mehmood on 18/08/2022.
//

import SwiftUI

@main
struct animalsApp: App {
    private enum Constants {
        static let animalsTitle: String = "Animals"
        static let animalsImage: String = "pawprint"
        static let settingsTitle: String = "Settings"
        static let settingsImage: String = "settings"
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    AnimalListView()
                        .background(Color.green)
                }
                .tabItem {
                    Label(Constants.animalsTitle,
                          image: Constants.animalsImage)
                }

                NavigationView {
                    SettingsView(animalViewModel: AnimalViewModel())
                }
                .tabItem {
                    Label(Constants.settingsTitle,
                          image: Constants.settingsImage)
                }
            }
        }
    }
}
