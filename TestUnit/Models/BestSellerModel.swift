//
//  BestSellerModel.swift
//  TestUnit
//
//  Created by Mac on 12.12.2022.
//

import SwiftUI

struct BestSellerModel: Hashable {
    func hash(into hasher: inout Hasher) {}
    var id = UUID().uuidString
    var item: BestSeller
    var image: Image
}
