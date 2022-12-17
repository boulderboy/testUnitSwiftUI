//
//  BestSellerRowView.swift
//  TestUnit
//
//  Created by Mac on 10.12.2022.
//

import SwiftUI

struct BestSellerRowView: View {
    
    var horizontalSpacing: CGFloat
//    let bestSellers: [BestSeller]
    @State var bestSellers: [BestSeller]
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        HStack(spacing: horizontalSpacing) {
            ForEach($bestSellers, id: \.self) { bestSeller in
                let value = bestSeller.wrappedValue
                BestSellerCardView(
                    title: value.title,
                    picture: value.picture,
                    discountPrice: value.discountPrice,
                    priceWithoutDiscount: value.priceWithoutDiscount,
                    isFavorites: value.isFavorites
                )
                    .frame(width: width, height: height)
            }
        }
        .padding(.vertical, 6)
    }
}
