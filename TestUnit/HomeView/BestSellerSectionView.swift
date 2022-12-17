//
//  BestSellerSectionVew.swift
//  TestUnit
//
//  Created by Mac on 10.12.2022.
//

import SwiftUI

struct BestSellerSectionView: View {
    
    private let itemsPerRow = CGFloat(2)
    private let horizontalSpacing = CGFloat(11)
    private let height = CGFloat(227)
    
    @Binding var cards: [BestSeller]
    
    var body: some View {
        ZStack {
            Color.mainBackgroundColor
            VStack {
                HomeSectionTitle(sectionName: "Best seller")
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(0..<cards.count, id: \.self) { i in
                        if i % Int(itemsPerRow) == 0 {
                            buildView(rowIndex: i)
                        }
                    }
                }
                .padding(.top, 15)
            }
        }
    }
    
    func buildView(rowIndex: Int) -> BestSellerRowView? {
            var rowCards = [BestSeller]()
            for itemIndex in 0..<Int(itemsPerRow) {
                if rowIndex + itemIndex < cards.count {
                    rowCards.append(cards[rowIndex + itemIndex])
                }
            }
            if !rowCards.isEmpty {
                return BestSellerRowView(horizontalSpacing: horizontalSpacing, bestSellers: rowCards, width: 181, height: height)
            }
            
            return nil
        }
    

}
