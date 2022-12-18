//
//  CartViewModel.swift
//  TestUnit
//
//  Created by Mac on 13.12.2022.
//

import SwiftUI

protocol Networking {
    func request<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void)
    func requestData(url: String, completion: @escaping (Result<Data?, Error>) -> Void)
}

final class NetworkService: Networking {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T>(url: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                guard let data = data else { return }

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let result = try decoder.decode(T.self, from: data)

                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }

    func requestData(url: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            completion(.success(data))
        }
        dataTask.resume()
    }
 }

protocol CartService {
    func loadCart(completion: @escaping (Result<Cart, Error>) -> Void)
}

final class CartServiceImpl: CartService {

    private enum URLS {
        static let cart = "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149"
    }

    private let networkService: Networking

    init(networkService: Networking) {
        self.networkService = networkService
    }

    func loadCart(completion: @escaping (Result<Cart, Error>) -> Void) {
        networkService.request(url: URLS.cart, completion: completion)
    }

}

final class CartViewModel: ObservableObject {
    
    @Published var cart: Cart = Cart.empty
    var cartItem: [CartItem] = []


    private let service: CartService

    init(service: CartService) {
        self.service = service

        getItems { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cart):
                DispatchQueue.main.async {
                    self.cart = cart
                }
            }
        }
    }
    
    private func getItems(completion: @escaping (Result<Cart, Error>) -> Void) {
        service.loadCart(completion: completion)
    }
}

