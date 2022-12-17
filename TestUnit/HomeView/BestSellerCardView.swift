//
//  BestSellerCardView.swift
//  TestUnit
//
//  Created by Mac on 10.12.2022.
//

import SwiftUI


struct BestSellerCardView: View {
    
//    @State var card: BestSellerModel
//
//    @State var bestSeller: BestSeller

    let title: String
    let picture: String
    let discountPrice: Int
    let priceWithoutDiscount: Int

//    var bestSeller: BestSeller

    @State var isFavorites: Bool

    var body: some View {
        ZStack {
            NavigationLink {
                ItemView()
            } label: {
                
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: picture)) { image in
                        image.resizable().scaledToFit().clipped()
                    } placeholder: {
                        Color.gray
                    }.frame(width: 181, height: 168)

                    HStack(alignment: .bottom) {
                        Text("$\(discountPrice)")
                            .padding(.leading,27)
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .fontWeight(.heavy)
                        Text("$\(priceWithoutDiscount)")
                            .padding(.leading, 7)
                            .font(.system(size: 13))
                            .strikethrough()
                            .foregroundColor(Color.gray)
                    }
                    Text(title)
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
                Image(systemName: isFavorites ? "heart.fill" : "heart")
                    .foregroundColor(.orange)
                    .padding()
                    .background(Color.white
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .frame(width: 30, height: 30))
                    .onTapGesture {
                        isFavorites.toggle()
                    }
                
            }
        }
    }
}

//struct BestSellerCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BestSellerCardView(card: tempCards.cards[0])
//    }
//}



