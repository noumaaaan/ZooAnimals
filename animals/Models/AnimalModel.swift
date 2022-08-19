//
//  AnimalModel.swift
//  animals
//
//  Created by Nouman Mehmood on 18/08/2022.
//

import Foundation

struct Animal: Identifiable, Codable {
    let id: Int
    let name: String
    let latin_name: String
    let animal_type: String
    let active_time: String
    var length_min: String
    var length_max: String
    var weight_min: String
    var weight_max: String
    let lifespan: String
    let habitat: String
    let diet: String
    let geo_range: String
    let image_link: String
}
