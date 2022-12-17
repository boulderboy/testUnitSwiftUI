//
//  CartViewModel.swift
//  TestUnit
//
//  Created by Mac on 13.12.2022.
//

import SwiftUI

final class CartViewModel: ObservableObject {
    
    @Published var items: [CartItemWithImage] = []
    @Published var cart: Cart = Cart.empty
    var cartItem: [CartItem] = []
    
    init() {
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
    
    func getItemsWithImages(completion: @escaping (Result<CartItemWithImage, Error>) -> Void) {
        for item in cart.basket {
            guard let url = URL(string: item.images) else { return }
            let urlSession = URLSession.shared
            let request = URLRequest(url: url)
            let dataTask = urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data,
                      let uiImage = UIImage(data: data) else { return }
                let cartItemWithImage = CartItemWithImage(id: item.id, item: item, image: Image(uiImage: uiImage))
                completion(.success(cartItemWithImage))
            }
            dataTask.resume()
        }
    }
    
    func getItems(completion: @escaping (Result<Cart, Error>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149") else { return }
        let urlSession = URLSession.shared
        let request = URLRequest(url: url)
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                guard let data = data else { return }
                let cart = try JSONDecoder().decode(Cart.self, from: data)
                completion(.success(cart))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}

// soliD
//
//protocol CartService {
//    func getItems(completion: @escaping (Result<Cart, Error>) -> Void)
//}
//
//final class CartServiceModel: CartService {
//
//    private enum URL {
//
//    }
//
//    private let session: URLSession
//
//    init(session: URLSession = .shared) {
//        self.session = session
//    }
//
//    func getItems(completion: @escaping (Result<Cart, Error>) -> Void) {
//        // implementation
//    }
//}


//class APIRequest {
//    private let session: URLSession
//    private let mapper: Mapper
//
//    init(session: URLSession = .shared, mapper: Mapper) {
//        self.session = session
//        self.mapper = mapper
//    }
//
//    func performRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
//        let task = session.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            guard let data = data else { return }
//            let jsonDecoder = JSONDecoder()
//            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//            do {
//                let item = try jsonDecoder.decode(T.self, from: data)
//                completion(.success(item))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }
//}

//final class Mapper {
//    private let decoder = JSONDecoder()
//
//    init(keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) {
//        decoder.keyDecodingStrategy = keyDecodingStrategy
//    }
//
//    func map<T: Decodable>(from data: Data) -> Result<T, Error> {
//        do {
//            let item = try jsonDecoder.decode(T.self, from: data)
//            return .success(item)
//        } catch {
//            return .failure(error)
//        }
//
//    }
//}
