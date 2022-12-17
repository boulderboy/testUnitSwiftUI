//
//  ItemViewModel.swift
//  TestUnit
//
//  Created by Mac on 13.12.2022.
//

import SwiftUI

class ItemViewModel: ObservableObject {
    
    @Published var selectedColor: Int = 0
    @Published var selectedMemory: Int = 0
    @Published var itemImages: [Image] = []
    @Published var item: Item = Item(id: "", CPU: "", camera: "", capacity: [""], color: [""], images: [""], isFavorites: false, price: 0, rating: 0, sd: "", ssd: "", title: "")
    
    init() {
  
    }
    
    
    func getData(competion: @escaping (Result<Item, Error>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5") else { return }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                competion(.failure(error))
                return
            }
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let item = try jsonDecoder.decode(Item.self, from: data)
                competion(.success(item))
            } catch {
                competion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    func loadImages() {
        getImages { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                self.itemImages.append(Image(uiImage: image))
            }
        }
    }
    
    func getImages(compeliton: @escaping (Result<UIImage, Error>) -> Void) {
        for imageUrl in item.images {
            guard let url = URL(string: imageUrl) else { return }
            let request = URLRequest(url: url)
            let urlSession = URLSession.shared
            let dataTask = urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    compeliton(.failure(error))
                    return
                }
                guard let data = data,
                    let uiImage = UIImage(data: data) else { return }
                compeliton(.success(uiImage))
            }
            dataTask.resume()
        }
    }
    
}
