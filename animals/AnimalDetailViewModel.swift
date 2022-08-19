//
//  AnimalDetailViewModel.swift
//  animals
//
//  Created by Nouman Mehmood on 19/08/2022.
//

import Foundation
import Combine

class AnimalDetailViewModel: ObservableObject {
    @Published var animal: Animal

    init(selectedAnimal: Animal) {
        self.animal = selectedAnimal
    }
}
