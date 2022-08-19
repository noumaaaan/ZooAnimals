//
//  UserSettings.swift
//  animals
//
//  Created by Nouman Mehmood on 19/08/2022.
//

import Foundation

class UserSettings: ObservableObject {
    static let shared = UserSettings()

    @Published var heightPreference: Height = UserDefaults.heightPreference
    @Published var weightPreference: Weight = UserDefaults.weightPreference

    func saveUserDefaults(heightValue: Height, weightValue: Weight) {
        UserDefaults.standard.set(heightValue.rawValue, forKey: "heightPreference")
        UserDefaults.standard.set(weightValue.rawValue, forKey: "weightPreference")
        heightPreference = heightValue
        weightPreference = weightValue
    }
}
