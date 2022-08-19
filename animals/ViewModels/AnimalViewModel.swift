//
//  AnimalViewModel.swift
//  animals
//
//  Created by Nouman Mehmood on 18/08/2022.
//

import Foundation
import Combine

class AnimalViewModel: ObservableObject {

    @Published var animals = [Animal]()
    @Published var errorMessage: String = ""

    var heightPreference: Height = UserDefaults.heightPreference
    var weightPreference: Weight = UserDefaults.weightPreference

    func saveUserDefaults(heightValue: Height, weightValue: Weight) {
        UserSettings.shared.saveUserDefaults(heightValue: heightValue, weightValue: weightValue)
    }

    private var cancellable = Set<AnyCancellable>()

    func fetchAnimals(numberOfAnimals: Int) {
        let urlString = "https://zoo-animal-api.herokuapp.com/animals/rand/\(numberOfAnimals)"
        if let url = URL(string: urlString) {

            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) -> Data in
                    guard
                        let response = response as? HTTPURLResponse,
                            response.statusCode >= 200 && response.statusCode <= 300 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: [Animal].self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion {
                    case .finished :
                        break
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                } receiveValue: { [weak self] (returnedAnimals) in
                    self?.animals = returnedAnimals
                }
                .store(in: &cancellable)
        }
    }

    func presentOnStartUp() -> Bool {
        return animals.isEmpty ? true : false
    }
}

extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

extension UserDefaults {
    private struct Keys {
        static let heightPreference = "heightPreference"
        static let weightPreference = "weightPreference"
    }

    static var heightPreference: Height {
        get {
            if let value = UserDefaults.standard.object(forKey: Keys.heightPreference) as? String {
                return Height(rawValue: value)!
            }
            else {
                return .feet
            }
        }
    }
    static var weightPreference: Weight {
        get {
            if let value = UserDefaults.standard.object(forKey: Keys.weightPreference) as? String {
                return Weight(rawValue: value)!
            }
            else {
                return .pounds
            }
        }
    }
}

private enum Conversions: Double {
    case centimetres = 30.48
    case metres = 0.3048
    case kilograms = 0.453592
    case stones = 0.0714286
}

extension Animal {

    func calculateLength(heightPreference: Height) -> (min: String, max: String) {
        switch heightPreference {
        case .feet:
            return ("\(self.length_min) \(heightPreference.unit)", "\(self.length_max) \(heightPreference.unit)")
        case .centimetres:
            if let minimum = Double(self.length_min), let maximum = Double(self.length_max) {
                return ("\((minimum * Conversions.centimetres.rawValue).truncate(places: 2)) \(heightPreference.unit)",
                        "\((maximum * Conversions.centimetres.rawValue).truncate(places: 2)) \(heightPreference.unit)")
            }
        case .metres:
            if let minimum = Double(self.length_min), let maximum = Double(self.length_max) {
                return ("\((minimum * Conversions.metres.rawValue).truncate(places: 2)) \(heightPreference.unit)",
                        "\((maximum * Conversions.metres.rawValue).truncate(places: 2)) \(heightPreference.unit)")
            }
        }

        return ("", "")
    }

    func calculateWeight(weightPreference: Weight) -> (min: String, max: String) {
        switch weightPreference {
        case .pounds:
            return ("\(self.weight_min) \(weightPreference.unit)",
             "\(self.weight_max) \(weightPreference.unit)")

        case .kilograms:
            if let minimum = Double(self.weight_min), let maximum = Double(self.weight_max) {
                return ("\((minimum * Conversions.kilograms.rawValue).truncate(places: 2)) \(weightPreference.unit)",
                        "\((maximum * Conversions.kilograms.rawValue).truncate(places: 2)) \(weightPreference.unit)")
            }
        case .stones:
            if let minimum = Double(self.weight_min), let maximum = Double(self.weight_max) {
                return ("\((minimum * Conversions.kilograms.rawValue).truncate(places: 2)) \(weightPreference.unit)",
                        "\((maximum * Conversions.kilograms.rawValue).truncate(places: 2)) \(weightPreference.unit)")
            }
        }

        return ("", "")
    }

//    static func formattedAnimalObject(animal: Animal) -> Animal {
//        let heightPreference: Height = UserDefaults.heightPreference
//        let weightPreference: Weight = UserDefaults.weightPreference
//        var animal = animal
//
//        switch heightPreference {
//        case .feet:
//            animal.length_min += " \(heightPreference.unit)"
//            animal.length_max += " \(heightPreference.unit)"
//        case .centimetres:
//            if let minimum = Double(animal.length_min), let maximum = Double(animal.length_max) {
//                animal.length_min = "\((minimum * Conversions.centimetres.rawValue).truncate(places: 2)) \(heightPreference.unit)"
//                animal.length_max = "\((maximum * Conversions.centimetres.rawValue).truncate(places: 2)) \(heightPreference.unit)"
//            }
//        case .metres:
//            if let minimum = Double(animal.length_min), let maximum = Double(animal.length_max) {
//                animal.length_min = "\((minimum * Conversions.metres.rawValue).truncate(places: 2)) \(heightPreference.unit)"
//                animal.length_max = "\((maximum * Conversions.metres.rawValue).truncate(places: 2)) \(heightPreference.unit)"
//            }
//        }
//
//        switch weightPreference {
//        case .pounds:
//            animal.weight_min += " \(weightPreference.unit)"
//            animal.weight_max += " \(weightPreference.unit)"
//        case .kilograms:
//            if let minimum = Double(animal.weight_min), let maximum = Double(animal.weight_max) {
//                animal.weight_min = "\((minimum * Conversions.kilograms.rawValue).truncate(places: 2)) \(weightPreference.unit)"
//                animal.weight_max = "\((maximum * Conversions.kilograms.rawValue).truncate(places: 2)) \(weightPreference.unit)"
//            }
//        case .stones:
//            if let minimum = Double(animal.weight_min), let maximum = Double(animal.weight_max) {
//                animal.weight_min = "\((minimum * Conversions.kilograms.rawValue).truncate(places: 2)) \(weightPreference.unit)"
//                animal.weight_max = "\((maximum * Conversions.kilograms.rawValue).truncate(places: 2)) \(weightPreference.unit)"
//            }
//        }
//        return animal
//    }
}
