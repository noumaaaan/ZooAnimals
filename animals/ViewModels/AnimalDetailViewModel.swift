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

    private var cancellables = Set<AnyCancellable>()

    init(selectedAnimal: Animal) {
        self.animal = selectedAnimal
    }
}
