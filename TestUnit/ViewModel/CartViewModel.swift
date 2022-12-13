//
//  CartViewModel.swift
//  TestUnit
//
//  Created by Mac on 13.12.2022.
//

import SwiftUI

final class CartViewModel: ObservableObject {
    
    @Published var items: [CartItemWithImage] = []
    @Published var cart: Cart = Cart(basket: [CartItem(id: 0, images: "", title: "", price: 0)], delivery: "", id: "", total: 0)
    var cartItem: [CartItem] = []
    
    init() {
        getItems { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cart):
                DispatchQueue.main.async {
                    print(cart)
                    self.cart = cart
                }
//                self.getItemsWithImages { result in
//                    switch result {
//                    case .failure(let error):
//                        print(error)
//                    case .success(let cartItemWithImage):
////                        DispatchQueue.main.async {
////                            print(cartItemWithImage)
////                            self.items.append(cartItemWithImage)
////                        }
//                    }
//                }
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

