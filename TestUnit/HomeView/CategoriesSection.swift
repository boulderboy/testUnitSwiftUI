//
//  CategoriesSection.swift
//  TestUnit
//
//  Created by Mac on 10.12.2022.
//

import SwiftUI

struct CategoriesSection: View {
    
    let categories = ["Phone", "Computer", "Health", "Books", "Other"]
    
    var body: some View {
        VStack(spacing: 0) {
            HomeSectionTitle(sectionName: "Select category")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(categories.self, id: \.self) { category in
                        Category(category: category)
                    }.padding(.horizontal, 11)
                        .padding(.vertical, 5)
                }
            }
            .padding(.vertical, 24)
        }
    }
}

struct Category: View {
    var category: String
    @State private var isSelected = false
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(isSelected ? Color.orange : Color.white)
                    .frame(width: 71)
                    .shadow(radius: 3)
                Image(category.lowercased())
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(isSelected ? .white : .gray)
                    .frame(width: 18, height: 30)
                    .onTapGesture {
                        isSelected.toggle()
                    }
            }
            Text("\(category)")
                .font(.system(size: 12))
        }
        
    }
}


struct CategoriesSection_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesSection()
    }
}
