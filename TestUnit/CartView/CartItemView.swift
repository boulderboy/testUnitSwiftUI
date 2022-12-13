//
//  CartItemView.swift
//  TestUnit
//
//  Created by Mac on 13.12.2022.
//

import SwiftUI

struct CartItemView: View {

    var item: CartItem
    @State var itemCount: Int = 1
    
    var body: some View {
  
            HStack {
                AsyncImage(url: URL(string: item.images)) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                } .frame(width: 89, height: 89)
                    .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .lineLimit(10)
                    Text("$\(item.price)")
                        .font(.system(size: 22))
                        .foregroundColor(Color.mainOrange)
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack {
                    Button {
                        itemCount += 1
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 1)
                    
                    Text("\(itemCount)")
                        .foregroundColor(.white)
                    
                    Button {
                        itemCount -= 1
                    } label: {
                        Image(systemName: "minus")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 1)

                }
                .frame(width: 26, height: 88)
                .background(Color.stepperBackground.cornerRadius(26))
                .padding(.trailing, 17)
                Image(systemName: "trash")
                    .foregroundColor(Color.stepperBackground)
                    .frame(width: 15, height: 15)
            }
    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView(item: CartItem(id: 0, images: "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-pro-silver-select?wid=470&hei=556&fmt=jpeg&qlt=95&.v=1631652954000", title: "asdf", price: 1500))
    }
}
