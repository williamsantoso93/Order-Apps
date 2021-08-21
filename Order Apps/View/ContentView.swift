//
//  ContentView.swift
//  Order Apps
//
//  Created by William Santoso on 21/08/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            Group {
                if !viewModel.listData.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.listData.indices, id: \.self) { index in
                                Button(action: {
                                    viewModel.addToCart(at: index)
                                }) {
                                    CardView(dataModel: viewModel.listData[index])
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("No data")
                    }
                }
            }
            .navigationTitle("Order")
            .navigationBarItems(trailing:
                                    NavigationLink(
                                        destination: CartView(viewModel: viewModel),
                                        label: {
                                            Image(systemName: "cart")
                                        })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
