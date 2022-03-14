//
//  HomeView.swift
//  CitySightsApp
//
//  Created by Samson Shuttle on 13/03/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    @State var selectedBusiness:Business?
    
    var body: some View {
        
        if model.restraurants.count != 0 || model.sights.count != 0 {
            
            // Navigation View
            NavigationView {
                // Determine if we should show list or map
                if !isMapShowing {
                    
                    // Show list
                    VStack (alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                            Text("San Francisco")
                            Spacer()
                            Button("Switch to map view") {
                                self.isMapShowing = true
                            }
                        }
                        Divider()
                        
                        BusinessList()
                    }.padding([.horizontal, .top])
                        .navigationBarHidden(true)
                    
                }
                else {
                    
                    ZStack (alignment: .top) {
                    
                        // Show map
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                
                                // Create a business detail view instance
                                // Pass in the secleted business
                                BusinessDetail(business: business)
                                
                            }
                        
                        // Rectangle overlay
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height: 48)
                            
                            
                            HStack {
                                Image(systemName: "location")
                                Text("San Francisco")
                                Spacer()
                                Button("Switch to list view") {
                                    self.isMapShowing = false
                                }
                            }.padding()
                            
                        }.padding()
                        
                    }
                    .navigationBarHidden(true)
                }
            }
            
           
            
        }
        else {
            ProgressView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
