//
//  BestSellerCardView.swift
//  TestUnit
//
//  Created by Mac on 10.12.2022.
//

import SwiftUI

struct BestSellerCardView: View {
    
    var card: BestSellerModel
    
    var body: some View {
        ZStack {
            NavigationLink {
                ItemView()
            } label: {
                
                VStack(alignment: .leading) {
                    card.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 181, height: 168)
                    HStack(alignment: .bottom) {
                        Text("$\(card.item.discountPrice)")
                            .padding(.leading,27)
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .fontWeight(.heavy)
                        Text("$\(card.item.priceWithoutDiscount)")
                            .padding(.leading, 7)
                            .font(.system(size: 13))
                            .strikethrough()
                            .foregroundColor(Color.gray)
                    }
                    Text(card.item.title)
                        .font(.system(size: 10))
                        .foregroundColor(.black)
                        .fontWeight(.light)
                        .padding(.leading, 27)
                }
                .frame(width: 181, height: 227)
                .background(Color.white
                    .cornerRadius(10))
            }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                
            } label: {
                Image(systemName: "heart")
                    .foregroundColor(.orange)
                    .padding()
                    .background(Color.white
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .frame(width: 30, height: 30))
                
            }
        }
    }
}

//struct BestSellerCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BestSellerCardView(card: tempCards.cards[0])
//    }
//}
