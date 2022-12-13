//
//  HomeModel.swift
//  TestUnit
//
//  Created by Mac on 12.12.2022.
//

import Foundation

struct Home: Codable {
    var homeStore: [HotSale]
    var bestSeller: [BestSeller]
}

struct HotSale: Codable, Hashable {
    let id: Int
    let title: String
    let subtitle: String
    let picture: String
}

struct BestSeller: Codable, Hashable {
    let id: Int
    let title: String
    let priceWithoutDiscount: Int
    let discountPrice: Int
    let picture: String
}
