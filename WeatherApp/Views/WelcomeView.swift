//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Deepak Raman on 7/17/24.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.dismiss) var dismiss
    /// Animation control var for the sun image shown on the welcome screen
    @State private var isAnimating = false
 
    var body: some View {
            VStack {
                Spacer()
                HStack(spacing: 20) {
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.yellow)
                        .scaledToFit()
                        .scaleEffect(isAnimating ? 1.5 : 1.0)
                        .onAppear() {
                            withAnimation(.easeInOut(duration: 1.0)
                                .repeatForever(autoreverses: true)) {
                                    isAnimating = true
                                }
                        }
                    Text("Weather")
                        .font(.system(size: 45))
                        .foregroundColor(.white)
                }
               
                Spacer()
                Button("Get Started") {
                    dismiss()
                }
                .buttonStyle(PurpleButton())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [Color("light"),
                                                Color("dark")],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    dismiss()
                }
            }
    }
}
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
