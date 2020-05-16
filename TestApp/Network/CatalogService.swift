//
//  CatalogService.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 17.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

public enum APIServiceError: Error {
    case requestFailure
    case invalidEndpoint
    case wrongHttpStatus
    case parseError
}

class CDCatalogService {

    private let baseURL = URL(string: "https://www.w3schools.com/xml/cd_catalog.xml")!
    private let xmlParser = XMLItemListParser<CompactDisk>()
    private let urlSession = URLSession.shared

    func fetch(completion: @escaping (Result<[CompactDisk], APIServiceError>) -> Void) {
        
        guard let url = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)?.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
     
        urlSession.dataTask(with: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let (response, data)):
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                        completion(.failure(.wrongHttpStatus))
                        return
                    }
                    self.xmlParser.parse(key: "cd", data: data, completion: completion)
                case .failure:
                    completion(.failure(.requestFailure))
                }
         }.resume()
    }
}

