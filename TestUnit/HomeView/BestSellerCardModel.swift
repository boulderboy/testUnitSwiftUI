//
//  BestSellerCardModel.swift
//  TestUnit
//
//  Created by Mac on 10.12.2022.
//

import SwiftUI

struct BestSellerCardModel: Identifiable {
    let id = UUID().uuidString
    let image = Image("samsungItem")
    let price = "$1400"
    let oldPrice = "$1500"
    let title = "Samsung Galaxy s20 Ultra"
}

struct tempCards {
    static let cards = [
        BestSellerCardModel(),
        BestSellerCardModel(),
        BestSellerCardModel(),
        BestSellerCardModel()
    ]
}
