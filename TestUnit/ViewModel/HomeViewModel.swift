//
//  HomeViewModel.swift
//  TestUnit
//
//  Created by Mac on 12.12.2022.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var home: Home = .empty
    
    init() {
        getInfoForHomePage { result in
            switch result {
            case .success(let home):
                DispatchQueue.main.async {
                    self.home = home
                }
            case .failure(let error):
                print(error)
            }
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
                completion(.failure(error))
            }
            
        }
        dataTsk.resume()
        
    }
}
