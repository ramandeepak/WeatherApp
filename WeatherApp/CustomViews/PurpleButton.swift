//
//  PurpleButton.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/17/24.
//

import SwiftUI

struct PurpleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.leading, 50)
            .padding(.trailing, 50)
            .padding(.top, 15)
            .padding(.bottom, 15)
            .foregroundColor(.white)
            .font(.title2)
            .bold()
            .background(.purple)
            .cornerRadius(25)
    }
}
