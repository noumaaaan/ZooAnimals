//
//  SharedComponents.swift
//  animals
//
//  Created by Nouman Mehmood on 18/08/2022.
//

import Foundation
import SwiftUI

struct AsyncImageView: View {
    let url: URL
    let placeholder: Color

    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                placeholder
                    .opacity(0.6)
            }
        }
    }
}

struct ButtonView: View {
    let value: String
    let color: Color

    var body: some View {
        Text(value)
            .foregroundColor(Color.white)
            .font(.headline)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(10)
    }
}
