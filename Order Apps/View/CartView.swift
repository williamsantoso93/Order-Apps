//
//  CartView.swift
//  Order Apps
//
//  Created by William Santoso on 21/08/21.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ScrollView {
            Group {
                if !viewModel.cartData.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Product yan akan anda pesan")
                            .bold()
                        ForEach(viewModel.cartData.indices, id: \.self) { index in
                            CartCardView(dataModel: $viewModel.cartData[index])
                        }
                    }
                    .padding()
                    .padding(.bottom, 125)
                } else {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("No data")
                    }
                }
            }
        }
        .navigationTitle("Cart")
        .overlay(
            VStack(alignment: .leading) {
                Spacer()
                if viewModel.total > 0 {
                    HStack {
                        VStack {
                            Text("Total Harga")
                                .bold()
                            
                            Text("Rp \(viewModel.total.splitDigit())")
                                .bold()
                                .foregroundColor(Color.orange)
                        }
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("Order")
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal, 20)
                                .background(Color.orange)
                                .cornerRadius(5)
                                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
                        }
                    }
                    .padding(30)
                    .padding(.horizontal, 20)
                    .background(RoundedCorners(color: .white, tl: 30, tr: 30, bl: 0, br: 0).ignoresSafeArea())
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
                }
            }
        )
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CartView(viewModel: ViewModel())
        }
    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}
