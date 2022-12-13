//
//  HomeViewModel.swift
//  TestUnit
//
//  Created by Mac on 12.12.2022.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var home: Home = Home(homeStore: [HotSale(id: 1, title: "", subtitle: "", picture: "")], bestSeller: [BestSeller(id: 1, title: "", priceWithoutDiscount: 0, discountPrice: 0, picture: "")])
    @Published var hotSales: [HotSaleModel] = [HotSaleModel(hotSale: HotSale(id: 1, title: "", subtitle: "", picture: ""), image: Image(systemName: "home"))]
    @Published var bestSellers: [BestSellerModel] = [BestSellerModel(item: BestSeller(id: 1, title: "", priceWithoutDiscount: 0, discountPrice: 0, picture: ""), image: Image(systemName: "house"))]
    
    init() {
        getInfoForHomePage { result in
            switch result {
            case .success(let home):
                DispatchQueue.main.async {
                    self.home = home
                    self.hotSales.removeAll()
                    self.bestSellers.removeAll()
                    self.loadHotSalesImages { result in
                        switch result {
                        case .success(let model):
                            DispatchQueue.main.async {
                                self.hotSales.append(model)
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                    self.loadBestSellerImages { result in
                        switch result {
                        case .success(let model):
                            DispatchQueue.main.async {
                                self.bestSellers.append(model)
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                    print("ok")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadHotSalesImages(completion: @escaping (Result<HotSaleModel, Error>) -> Void) {
        for item in home.homeStore {
            guard let url = URL(string: item.picture) else { return }
            let urlSession = URLSession.shared
            let request = URLRequest(url: url)
            let dataTask = urlSession.dataTask(with: request) {data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data,
                      let uiImage = UIImage(data: data)
                else { return }
                let model = HotSaleModel(hotSale: item, image: Image(uiImage: uiImage))
                completion(.success(model))
            }
            dataTask.resume()
        }
    }
    
    func loadBestSellerImages(completion: @escaping (Result<BestSellerModel, Error>) -> Void) {
        for item in home.bestSeller {
            guard let url = URL(string: item.picture) else { return }
            let urlSession = URLSession.shared
            let request = URLRequest(url: url)
            let dataTask = urlSession.dataTask(with: request) {data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data,
                      let uiImage = UIImage(data: data)
                else { return }
                let model = BestSellerModel(item: item, image: Image(uiImage: uiImage))
                completion(.success(model))
            }
            dataTask.resume()
        }
    }
    
    func getInfoForHomePage(completion: @escaping (Result<Home, Error>) -> Void) {
        
        guard let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175") else { return }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let urlSession = URLSession.shared
        
        let request = URLRequest(url: url)
        let dataTsk = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                guard let data = data else { return }
                let home = try jsonDecoder.decode(Home.self, from: data)
                completion(.success(home))
            } catch {
                print(error)
                completion(.failure(error))
            }
            
        }
        dataTsk.resume()
        
    }
}
