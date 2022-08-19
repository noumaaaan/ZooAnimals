//
//  Enums.swift
//  animals
//
//  Created by Nouman Mehmood on 18/08/2022.
//

import Foundation

enum Height: String, CaseIterable {
    case feet = "Feet"
    case centimetres = "Centimetres"
    case metres = "Metres"

    var unit: String {
        switch self {
        case .feet:
            return "ft"
        case .centimetres:
            return "cm"
        case .metres:
            return "m"
        }
    }
}

enum Weight: String, CaseIterable {
    case pounds = "Pounds"
    case kilograms = "Kilograms"
    case stones = "Stones"

    var unit: String {
        switch self {
        case .pounds:
            return "lbs"
        case .kilograms:
            return "kg"
        case .stones:
            return "st"
        }
    }
}
