//
//  AnimalDetailView.swift
//  animals
//
//  Created by Nouman Mehmood on 18/08/2022.
//

import SwiftUI

private enum Constants {
    static let secondaryColor: Color = Color("SecondaryAccentColor")
    static let imageSize: CGFloat = 200
    static let horizontalPadding: CGFloat = 20
    static let detailRowPadding: CGFloat = 10

    static let name: String = "Animal name"
    static let diet: String = "Diet"
    static let weight: String = "Animal weight"
    static let height: String = "Animal height"
}

struct AnimalDetailView: View {
//    @ObservedObject var animalViewModel: AnimalViewModel
    @ObservedObject var viewModel: AnimalDetailViewModel
//    let animal: Animal

    var body: some View {
        VStack {
            ScrollView {
                if let url = URL(string: self.viewModel.animal.image_link) {
                    AsyncImageView(url: url, placeholder: Constants.secondaryColor)
                        .padding(Constants.horizontalPadding)
                }
                DetailViewRow(heading: Constants.name, value: "\(self.viewModel.animal.name) (\(self.viewModel.animal.latin_name))")
                DetailViewRow(heading: Constants.diet, value: self.viewModel.animal.diet)
                DetailViewRow(heading: Constants.height, value: "\(self.viewModel.animal.length_min) - \(self.viewModel.animal.length_max)")
                DetailViewRow(heading: Constants.weight, value: "\(self.viewModel.animal.weight_min) - \(self.viewModel.animal.weight_max)")
            }
            .frame(maxHeight: .infinity)
        }
        .navigationTitle(self.viewModel.animal.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailViewRow: View {
    let heading: String
    let value: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(heading)
                .font(.subheadline).bold()
                .foregroundColor(Constants.secondaryColor)
            Text(value)
                .font(.headline)
                .foregroundColor(.accentColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.vertical, Constants.detailRowPadding)
    }
}

struct AnimalDetailView_Previews: PreviewProvider {
    static var previews: some View {

        let animal = Animal(
            id: 162,
            name: "Siamang",
            latin_name: "Hylobates syndactylus",
            animal_type: "Mammal",
            active_time: "Diurnal",
            length_min: "1.90",
            length_max: "2.00",
            weight_min: "20",
            weight_max: "23",
            lifespan: "23",
            habitat: "Tropical rainforest",
            diet: "Primarily fruit and leaves, some invertebrates",
            geo_range: "Malaysia and Sumatra",
            image_link: "https://upload.wikimedia.org/wikipedia/commons/a/a4/DPPP_5348.jpg")

        NavigationView {
            AnimalDetailView(viewModel: AnimalDetailViewModel(selectedAnimal: animal))
                .navigationTitle(animal.name)
        }
    }
}
