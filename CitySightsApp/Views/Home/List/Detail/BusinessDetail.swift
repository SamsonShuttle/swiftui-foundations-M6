//
//  BusinessDetail.swift
//  CitySightsApp
//
//  Created by Samson Shuttle on 13/03/2022.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            VStack (spacing: 0		) {
                GeometryReader() { geo in
                    // Bussiness image
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                        .scaledToFill()
                    
                }.ignoresSafeArea(.all, edges: .top)
                
                // Open closed indicator
                ZStack (alignment: .leading) {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                }
                
            }
            
            
            Group {
                // Business Name
                Text(business.name!)
                    .font(.largeTitle)
                    .padding()
                
                // Address Loop through
                if business.location?.displayAddress != nil {
                    ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                        Text(displayLine).padding(.horizontal)
                    }
                }
                else {
                    Text("26 Steeple Way").padding(.horizontal)
                    Text("Rushden").padding(.horizontal)
                    Text("NN10 0UT").padding(.horizontal)
                }
                
                // Rating
                Image("regular_\(business.rating ?? 0)")
                    .padding()
                
                Divider()
                
                // Phone
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }.padding()
                
                Divider()
                
                // Reviews
                HStack {
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                Divider()
                
                // Website
                HStack {
                    Text("Website:")
                        .bold()
                    Text(business.displayPhone ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Vist", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                Divider()
                
            }
            
            // Get Directions Button
            Button {
                // TODO: Show Directions
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                }
            }

            
        }
        
    }
}

/*
struct BusinessDetail_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDetail(business: Business.getTestData())
    }
}
*/
