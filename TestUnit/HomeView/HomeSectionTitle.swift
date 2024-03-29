//
//  HomeSectionTitle.swift
//  TestUnit
//
//  Created by Mac on 10.12.2022.
//

import SwiftUI

struct HomeSectionTitle: View {
    
    var sectionName: String
    
    var body: some View {
        HStack {
            Text(sectionName)
                .font(.system(size: 25))
                .fontWeight(.heavy)
            Spacer()
            Text("see more")
                .font(.system(size: 15))
                .foregroundColor(Color.mainOrange)
        }
    }
}

