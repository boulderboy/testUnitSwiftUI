//
//  HomeViewModel.swift
//  TestUnit
//
//  Created by Mac on 12.12.2022.
//

import Foundation
import SwiftUI


protocol HomeService {
    func loadHomePage(completion: @escaping (Result<Home, Error>) -> Void)
}

final class HomeServiceImpl: HomeService {

    private enum URLS {
        static let home = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
    }

    private let networkService: Networking

    init(networkService: Networking) {
        self.networkService = networkService
    }

    func loadHomePage(completion: @escaping (Result<Home, Error>) -> Void) {
        networkService.request(url: URLS.home, completion: completion)
    }

}

class HomeViewModel: ObservableObject {
    
    @Published var home: Home = .empty

    private var service: HomeService
    
    init(service: HomeService) {
        self.service = service

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
    
    private func getInfoForHomePage(completion: @escaping (Result<Home, Error>) -> Void) {
        service.loadHomePage(completion: completion)
    }
}
