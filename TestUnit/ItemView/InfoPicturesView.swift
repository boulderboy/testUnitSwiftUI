//
//  InfoPicturesView.swift
//  TestUnit
//
//  Created by Mac on 11.12.2022.
//

import SwiftUI

struct InfoPicturesView: View {
    
    var item: Item
    @State var cells = [PrarmetrrView]()
    let parameters = ["cpu", "camera", "memorychip", "sd"]
    
    var body: some View {
        HStack {
            ForEach(cells) { cell in
                cell
                if !(cells.firstIndex(of: cell) == cells.count - 1) {
                    Spacer()
                }
            }
        }
        .onAppear {
            createCells()
        }
    }
    
    func createCells() {
        cells = []
        for parameter in parameters {
            switch parameter {
            case "cpu":
                cells.append(PrarmetrrView(imageName: "cpu", parameterLabel: item.CPU))
            case "camera":
                cells.append(PrarmetrrView(imageName: "camera", parameterLabel: item.camera))
            case "memorychip":
                cells.append(PrarmetrrView(imageName: "memorychip", parameterLabel: item.ssd))
            case "sd":
                cells.append(PrarmetrrView(imageName: "sdcard", parameterLabel: item.sd))
            default:
                return
            }
        }
    }
}

//struct InfoPicturesView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoPicturesView(item: Item.testItem)
//    }
//}
