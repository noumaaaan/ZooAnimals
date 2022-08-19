//
//  SettingsView.swift
//  animals
//
//  Created by Nouman Mehmood on 18/08/2022.
//

import SwiftUI

struct SettingsView: View {

    private enum Constants {
        static let selectPreference: String = "Select your measurement preference"
        static let titleText: String = "Settings"
        static let saved: String = "Saved!"
        static let height: String = "Height"
        static let weight: String = "Weight"
        static let saveButton: String = "Save"
        static let secondaryColor: Color = Color("SecondaryAccentColor")
        static let topPadding: CGFloat = 40
        static let bottomPadding: CGFloat = 20
        static let horizontalPadding: CGFloat = 30
    }

    @ObservedObject var animalViewModel: AnimalViewModel
    @State var hideSuccessMessage: Bool = true

    var body: some View {

        VStack {
            Text(Constants.selectPreference)
                .font(.headline)
                .foregroundColor(Color.accentColor)
                .padding(.top, Constants.topPadding)
                .padding(.bottom, Constants.bottomPadding)

            Text(Constants.height)
                .font(.subheadline).bold()
                .foregroundColor(Constants.secondaryColor)
                .frame(maxWidth: .infinity, alignment: .leading)

            Picker(Constants.height, selection: self.$animalViewModel.heightPreference) {
                ForEach(Height.allCases, id: \.self) { height in
                    Text(height.rawValue)
                        .tag(height)
                }
            }
            .padding(.bottom, Constants.topPadding)
            .pickerStyle(.segmented)

            Text(Constants.weight)
                .font(.subheadline).bold()
                .foregroundColor(Constants.secondaryColor)
                .frame(maxWidth: .infinity, alignment: .leading)

            Picker(Constants.weight, selection: $animalViewModel.weightPreference) {
                ForEach(Weight.allCases, id: \.self) { weight in
                    Text(weight.rawValue)
                        .tag(weight)
                }
            }
            .padding(.bottom, Constants.topPadding)

            Button {
                self.animalViewModel.saveUserDefaults(heightValue: self.animalViewModel.heightPreference,
                                                      weightValue: self.animalViewModel.weightPreference)
                hideSuccessMessage = false
            } label: {
                ButtonView(value: Constants.saveButton, color: Color.accentColor)
            }
            .tint(Color.secondary)
            .padding(.bottom, Constants.bottomPadding)

            Text(Constants.saved)
                .font(.subheadline).bold()
                .foregroundColor(Color.green)
                .opacity(hideSuccessMessage ? 0 : 1)
            Spacer()
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .pickerStyle(.segmented)
        .navigationTitle(Constants.titleText)
        .onAppear {
            hideSuccessMessage = true
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView(animalViewModel: AnimalViewModel())
                .navigationTitle("Settings")
        }
    }
}
