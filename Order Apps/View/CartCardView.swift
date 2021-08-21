//
//  CartCardView.swift
//  Order Apps
//
//  Created by William Santoso on 21/08/21.
//

import SwiftUI

struct CartCardView: View {
    @Binding var dataModel: DataModel
    var body: some View {
        HStack(spacing: 0.0) {
            ZStack {
                Color.gray.opacity(0.1)
                Image(systemName: "photo")
            }
            .cornerRadius(10)
            .aspectRatio(1, contentMode: .fit)
            .padding()
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text(dataModel.title.capitalized)
                    .font(.title3)
                    .lineLimit(1)
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Rp \(dataModel.price.splitDigit())")
                            .foregroundColor(Color.orange)
                            .padding(.bottom, 4)
                        Spacer(minLength: 0)
                        Text("(Baru)")
                            .foregroundColor(Color.gray)
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            if dataModel.qty > 0 {
                                dataModel.qty -= 1
                            }
                        }) {
                            Text("-")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color.red.opacity(0.9))
                                .cornerRadius(5)
                        }
                        
                        Text("\(dataModel.qty)")
                            .bold()
                            .padding(.horizontal)
                        
                        Button(action: {
                            dataModel.qty += 1
                        }) {
                            Text("+")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color.blue.opacity(0.9))
                                .cornerRadius(5)
                        }
                    }
                }
            }
            .padding(.vertical)
            .padding(.trailing, 25)
            
            Spacer(minLength: 0)
        }
        .frame(height: 120)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct CartCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.1)
            CartCardView(dataModel: .constant(.init(title: "title", price: "1221212", addedUserName: "user", locationName: "jakarta")))
                .padding()
        }
    }
}
