//
//  ItemViewModel.swift
//  TestUnit
//
//  Created by Mac on 13.12.2022.
//

import SwiftUI

protocol ItemService {
    func loadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void)
    func loadItem(completion: @escaping (Result<Item, Error>) -> Void)
}

final class ItemServiceImpl: ItemService {

    private enum URLS {
        static let item = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
    }

    private let networkService: Networking

    init(networkService: Networking) {
        self.networkService = networkService
    }

    func loadItem(completion: @escaping (Result<Item, Error>) -> Void) {
        networkService.request(url: URLS.item, completion: completion)
    }

    func loadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        networkService.requestData(url: url) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    completion(.success(image))
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

}

class ItemViewModel: ObservableObject {
    
    @Published var selectedColor: Int = 0
    @Published var selectedMemory: Int = 0
    @Published var itemImages: [Image] = []
    @Published var item: Item = Item(id: "", CPU: "", camera: "", capacity: [""], color: [""], images: [""], isFavorites: false, price: 0, rating: 0, sd: "", ssd: "", title: "")


    private let service: ItemService

    init(service: ItemService) {
        self.service = service
    }

    func getData(completion: @escaping (Result<Item, Error>) -> Void) {
        service.loadItem(completion: completion)
    }

    func getImages(completion: @escaping (Result<UIImage, Error>) -> Void) {
        for imageUrl in item.images {
            service.loadImage(url: imageUrl, completion: completion)
        }
    }
}
