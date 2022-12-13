//
//  SelectOptionsView.swift
//  TestUnit
//
//  Created by Mac on 11.12.2022.
//

import SwiftUI

struct SelectOptionsView: View {
    
    @Binding var item: Item
    
    var body: some View {
        HStack{
            ForEach(item.color, id: \.self){ color in
                Button {
                    
                } label: {
                    Color.init(hex: color)
                        .cornerRadius(20)
                        .overlay {
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                        }
                }
                .frame(width: 40, height: 40)
            }
            Spacer()
            ForEach(item.capacity, id:\.self){ capacity in
                Button {
                    
                } label: {
                    Text("\(capacity) GB")
                        .font(.system(size: 13))
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.mainOrange.cornerRadius(10))
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

//struct SelectOptionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectOptionsView(item: Item.testItem)
//    }
//}
