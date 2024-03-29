//
//  TotalView.swift
//  TestUnit
//
//  Created by Mac on 13.12.2022.
//

import SwiftUI

struct TotalView: View {
    
    var totalPrice: Int
    var deliveryPrice: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Total")
                Text("Delivery")
            }
            .foregroundColor(.white)
            .fontWeight(.thin)
            Spacer()
            VStack(alignment: .leading) {
                Text("$\(totalPrice)")
                Text(deliveryPrice)
            }
            .foregroundColor(.white)
            .fontWeight(.semibold)
        }
    }
}

struct TotalView_Previews: PreviewProvider {
    static var previews: some View {
        TotalView(totalPrice: 6000, deliveryPrice: "Free")
    }
}
