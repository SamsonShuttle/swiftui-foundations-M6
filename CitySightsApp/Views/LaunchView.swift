//
//  LaunchView.swift
//  CitySightsApp
//
//  Created by Samson Shuttle on 07/03/2022.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        
        // Detect the authorization status of geolocating the user
        if model.authorizationState == .notDetermined {
            // If undetermind, show onboarding
            OnboardingView()
        }
        else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            // If approved, show home view
            HomeView()
        }
        else {
            // If denied show denied view
            LocationDeniedView()
        }
        
    }
}

struct LaunchViewView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
