//
//  AnimalListView.swift
//  animals
//
//  Created by Nouman Mehmood on 18/08/2022.
//

import SwiftUI
import BottomSheet

private enum Constants {
    static let thumbnailSize: CGFloat = 100
    static let cornerRadius: CGFloat = 5
    static let rowHeight: CGFloat = 120
    static let rowPadding: CGFloat = 20
    static let refreshIcon: String = "refresh"
    static let title: String = "Animals"
    static let secondaryColor: Color = Color("SecondaryAccentColor")
}

struct AnimalListView: View {
    @ObservedObject var animalViewModel = AnimalViewModel()
    @State var presentAnimalRequest: Bool = false
    @State var presentSettings: Bool = false

    var body: some View {
        List {
            if animalViewModel.errorMessage != "" {
                Text(animalViewModel.errorMessage)
            } else {
                ForEach(animalViewModel.animals) { animal in
                    NavigationLink {
                        AnimalDetailView(viewModel: AnimalDetailViewModel(selectedAnimal: animal))
                    } label: {
                        AnimalRowView(animal: animal)
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle(Constants.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentAnimalRequest = true
                } label: {
                    Image(Constants.refreshIcon)
                }
            }
        }
        .onAppear {
            presentAnimalRequest = animalViewModel.presentOnStartUp()
        }
        .bottomSheet(isPresented: $presentAnimalRequest,
                     height: 400,
                     topBarCornerRadius: 20,
                     showTopIndicator: false) {
            AnimalRequest(animalViewModel: animalViewModel, presentModal: $presentAnimalRequest)
        }
    }
}

struct AnimalRowView: View {
    let animal: Animal

    var body: some View {
        HStack(spacing: Constants.rowPadding) {
            if let url = URL(string: animal.image_link) {
                AsyncImageView(url: url, placeholder: Constants.secondaryColor)
                    .frame(width: Constants.thumbnailSize, height: Constants.thumbnailSize)
                    .cornerRadius(Constants.cornerRadius)
            }

            VStack(alignment: .leading) {
                Text(animal.name)
                    .font(.headline)
                    .foregroundColor(Constants.secondaryColor)

                Text(animal.habitat)
                    .font(.subheadline)
                    .foregroundColor(Color.accentColor)
            }
            .frame(alignment: .leading)
        }
        .frame(height: Constants.rowHeight)
        .padding(.vertical, 5)
    }
}

struct AnimalListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalListView(animalViewModel: AnimalViewModel())
    }
}
