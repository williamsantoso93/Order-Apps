//
//  CardView.swift
//  Order Apps
//
//  Created by William Santoso on 21/08/21.
//

import SwiftUI

struct CardView: View {
    var dataModel: DataModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Color.gray.opacity(0.1)
                Image(systemName: "photo")
            }
            .frame(height: 175)
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text(dataModel.title.capitalized)
                    .font(.title3)
                    .lineLimit(1)
                Text("Rp \(dataModel.price.splitDigit())")
                    .foregroundColor(Color.orange)
                    .padding(.bottom, 4)
                HStack {
                    Image(systemName: "location.fill")
                    Text(dataModel.locationName)
                        .lineLimit(1)
                }
                .foregroundColor(Color.gray)
                HStack {
                    Image(systemName: "person.fill")
                    Text(dataModel.addedUserName)
                        .lineLimit(1)
                }
                .foregroundColor(Color.gray)
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.1)
            CardView(dataModel: .init(title: "title", price: "1221212", addedUserName: "user", locationName: "jakarta"))
                .padding()
        }
        
    }
}
