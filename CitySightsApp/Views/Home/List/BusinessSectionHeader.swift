//
//  BusinessSectionHeader.swift
//  CitySightsApp
//
//  Created by Samson Shuttle on 13/03/2022.
//

import SwiftUI

struct BusinessSectionHeader: View {
    
    var title: String
    
    var body: some View {
        
        ZStack (alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
        
            Text(title).bold()
        
        }
    }
    
    
}

struct BusinessSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSectionHeader(title: "Restaurants")
    }
}
