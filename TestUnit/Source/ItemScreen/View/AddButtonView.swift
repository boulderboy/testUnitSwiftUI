//
//  AddButtonView.swift
//  TestUnit
//
//  Created by Mac on 11.12.2022.
//

import SwiftUI

struct AddButtonView: View {
    
    private let price: Int
    
    init(price: Int) {
        self.price = price
    }
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Text("Add to cart")
                Spacer()
                Text("$1500")
            }
            .foregroundColor(.white)
            .font(.system(size: 21))
            .fontWeight(.medium)
            .padding(.horizontal, 38)
            .padding(.vertical, 14)
            .background(Color.mainOrange.cornerRadius(10))
        }

    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(price: 1500)
    }
}
