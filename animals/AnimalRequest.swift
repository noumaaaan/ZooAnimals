//
//  AnimalRequest.swift
//  animals
//
//  Created by Nouman Mehmood on 18/08/2022.
//

import SwiftUI

struct AnimalRequest: View {

    private enum Constants {
        static let titleText: String = "Choose a number between 1 and 10"
        static let saveButton: String = "Save"
        static let dismissButton: String = "Dismiss"
        static let secondaryColor: Color = Color("SecondaryAccentColor")
        static let height: CGFloat = 200
        static let verticalPadding: CGFloat = 50
        static let horizontalPadding: CGFloat = 30
    }

    @ObservedObject var animalViewModel: AnimalViewModel
    @State var number: Double = 5
    @Binding var presentModal: Bool

    var body: some View {

        ZStack(alignment: .bottom) {
            VStack {
                Text(Constants.titleText)
                    .font(.headline)

                Slider(value: $number, in: 1...10, step: 1)
                    .tint(Constants.secondaryColor)
                Text("\(Int(number))")
                    .font(.title2).bold()

                HStack(spacing: 15) {
                    Button {
                        presentModal = false
                    } label: {
                        ButtonView(value: Constants.dismissButton,
                                    color: Constants.secondaryColor)
                    }

                    Button {
                        presentModal = false
                        self.animalViewModel.fetchAnimals(numberOfAnimals: Int(number))
                    } label: {
                        ButtonView(value: Constants.saveButton,
                                    color: Color.accentColor)
                    }
                }
                .padding()
            }
            .frame(height: Constants.height)
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.verticalPadding)
            .background(Color.white)
        }
    }
}

struct AnimalRequest_Previews: PreviewProvider {
    static var previews: some View {
        AnimalRequest(animalViewModel: AnimalViewModel(), presentModal: .constant(true))
    }
}
