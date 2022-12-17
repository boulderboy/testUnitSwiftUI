//
//  InfoPicturesView.swift
//  TestUnit
//
//  Created by Mac on 11.12.2022.
//

import SwiftUI

struct InfoPicturesView: View {
    
    @Binding var item: Item
    @State var cells = [PrarmetrrView]()

    var body: some View {
        HStack {
            ForEach(cells) { cell in
                cell
                if !(cells.firstIndex(of: cell) == cells.count - 1) {
                    Spacer()
                }
            }
        }.onChange(of: item, perform: { _ in
            createCells()
        })
    }
    
    func createCells() {
        var result = [PrarmetrrView]()

        for parameter in ["cpu", "camera", "memorychip", "sd"] {
            switch parameter {
            case "cpu":
                result.append(PrarmetrrView(imageName: "cpu", parameterLabel: item.CPU))
            case "camera":
                result.append(PrarmetrrView(imageName: "camera", parameterLabel: item.camera))
            case "memorychip":
                result.append(PrarmetrrView(imageName: "memorychip", parameterLabel: item.ssd))
            case "sd":
                result.append(PrarmetrrView(imageName: "sdcard", parameterLabel: item.sd))
            default:
                return
            }
        }

        cells = result
    }

    private func imageName(for item: String) -> String? {
        print("Image name for \(item)")
        switch item.lowercased() {
        case "cpu":
            return "cpu"
        case "camera":
            return "camera"
        case "sd":
            return "memorychip"
        case "ssd":
            return "sdcard"
        default:
            return nil
        }
    }
}

//struct InfoPicturesView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoPicturesView(item: Item.testItem)
//    }
//}
