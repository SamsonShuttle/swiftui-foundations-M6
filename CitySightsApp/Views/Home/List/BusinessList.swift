//
//  BusinessList.swift
//  CitySightsApp
//
//  Created by Samson Shuttle on 13/03/2022.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView (showsIndicators: false) {
            LazyVStack (alignment: .leading, pinnedViews: [.sectionHeaders]) {
                
                BusinessSection(title: "Restaurants", business: model.restraurants)
                BusinessSection(title: "Sights", business: model.sights)
                Divider()
                    
                
            }
        }
        
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
