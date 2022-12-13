//
//  BestSellerRowView.swift
//  TestUnit
//
//  Created by Mac on 10.12.2022.
//

import SwiftUI

struct BestSellerRowView: View {
    
    var horizontalSpacing: CGFloat
    let cards: [BestSellerModel]
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        HStack(spacing: horizontalSpacing) {
            ForEach(cards, id: \.self) { card in
                BestSellerCardView(card: card)
                    .frame(width: width, height: height)
            }
        }
        .padding(.vertical, 6)
    }
}

//struct BestSellerRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        BestSellerRowView(horizontalSpacing: 11, cards: tempCards.cards, width: 181, height: 227)
//    }
//}
