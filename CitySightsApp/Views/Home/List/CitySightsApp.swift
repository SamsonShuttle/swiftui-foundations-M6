//
//  CitySightsAppApp.swift
//  CitySightsApp
//
//  Created by Samson Shuttle on 07/03/2022.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
