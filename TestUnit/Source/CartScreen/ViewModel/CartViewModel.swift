//
//  CartViewModel.swift
//  TestUnit
//
//  Created by Mac on 13.12.2022.
//

import SwiftUI

final class CartViewModel: ObservableObject {
    
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
    
    private func getItems(completion: @escaping (Result<Cart, Error>) -> Void) {
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

