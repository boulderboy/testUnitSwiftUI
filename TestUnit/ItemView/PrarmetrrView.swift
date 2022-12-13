//
//  PrarmetrrView.swift
//  TestUnit
//
//  Created by Mac on 11.12.2022.
//

import SwiftUI

struct PrarmetrrView: View, Identifiable, Equatable {
    
    var id = UUID().uuidString
    var imageName: String
    var parameterLabel: String
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: imageName)
                .frame(width: 28, height: 28)
                .foregroundColor(.gray)
            Text(parameterLabel)
                .foregroundColor(.gray)
                .font(.system(size: 11))
        }
    }
}

struct PrarmetrrView_Previews: PreviewProvider {
    static var previews: some View {
        PrarmetrrView(imageName: "camera", parameterLabel: "123 Gb")
    }
}
