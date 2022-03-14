//
//  LocationDeniedView.swift
//  CitySightsApp
//
//  Created by Samson Shuttle on 14/03/2022.
//

import SwiftUI

struct LocationDeniedView: View {
    
    private let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        
        VStack (spacing: 20) {
            Spacer()
            
            Text("Whoops!")
                .font(.title)
            
            Text("We need to access your location to provide you with the best sights in your area, change your decision at any time in Settings")
            

            Spacer()
            
            Button {
                
                // Open Settings
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    
                    if UIApplication.shared.canOpenURL(url) {
                        // If we can open settings url, then open it
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        
                    }
                    
                }
                
            } label: {
                ZStack{
                    Rectangle()
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    
                    Text("Open Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                }.padding()
            }

            
            Spacer()
        }
        .padding()
        .ignoresSafeArea()
        .background(backgroundColor)
        .multilineTextAlignment(.center)
        .foregroundColor(.white)
        
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
