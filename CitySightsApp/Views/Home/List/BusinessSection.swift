//
//  BusinessSection.swift
//  CitySightsApp
//
//  Created by Samson Shuttle on 13/03/2022.
//

import SwiftUI

struct BusinessSection: View {
    
    var title: String
    var business: [Business]
    
    var body: some View {
        
        Section (header: BusinessSectionHeader(title: title)) {
            ForEach(business) { business in
                NavigationLink {
                    
                    BusinessDetail(business: business)
                    
                } label: {
                    
                    BusinessRow(business: business)
                    
                }
                
            }
        }
        
    }
}
