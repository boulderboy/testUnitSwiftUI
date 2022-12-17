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
//                BestSellerCardView(
//                    bestSeller: bestSeller.wrappedValue,
//                    isFavorites: bestSeller.isFavorites
//                     //bestSellerBinding(bestSeller)
//                )
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


    private func bestSellerBinding(_ bestSeller: BestSeller) -> Binding<BestSeller> {
        .init {
            bestSeller
        } set: { bestSeller in
//            bestSeller.isFavorites.toggle()
//            bestSeller.isFavorites.toggle()
            print("bestSeller set \(bestSeller.isFavorites)")
        }

    }
//
//    private func todoRowBinding(_ todo: Todo) -> Binding<Todo> {
//        .init(get: {
//            todo
//        }, set: { mutatedTodo in
//            let isToggleChange = mutatedTodo.isCompleted != todo.isCompleted
//            if isToggleChange {
//                handleToggleChange(mutatedTodo)
//            } else {
//                controller.update(mutatedTodo)
//            }
//        })
//    }
}

//struct BestSellerRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        BestSellerRowView(horizontalSpacing: 11, cards: tempCards.cards, width: 181, height: 227)
//    }
//}
