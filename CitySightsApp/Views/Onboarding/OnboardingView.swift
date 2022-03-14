//
//  OnboardingView.swift
//  CitySightsApp
//
//  Created by Samson Shuttle on 14/03/2022.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var model: ContentModel
    @State private var tabSelection = 0
    
    private let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private let turquoise = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    var body: some View {
        
        VStack {
            
            // Tab view
            TabView(selection: $tabSelection) {
                
                // First tab
                VStack (spacing: 20) {
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to City Sights")
                        .bold()
                        .font(.title)
                    Text("City Sights helps you find the best of the city")
                }
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .tag(0)
                
                // Second tab
                VStack (spacing: 20) {
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    Text("Ready to discover your city?")
                        .bold()
                        .font(.title)
                    Text("We'll show you the best restaurants, venus and more, based on your location!")
                }
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .tag(1)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            // Button
            Button {
                
                // Detect which tabe it is
                if tabSelection == 0 {
                    
                    tabSelection = 1
                }
                else {
                    
                    // TODO: Request for Geolocation permisson
                    model.requestGeolocationPermission()
                    
                }
                
            } label: {
                
                ZStack {
                    
                   Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text(tabSelection == 0 ? "Next" : "Get my Location")
                        .bold()
                        .padding()
                }
                
            }
            .accentColor(tabSelection == 0 ? blue : turquoise)
            .padding()

            Spacer()
            
        }
        .background(tabSelection == 0 ? blue : turquoise)
        .ignoresSafeArea()
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
