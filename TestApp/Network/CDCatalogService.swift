//
//  CDCatalogService.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 17.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

enum Constants {
    static let baseURL = "https://www.w3schools.com/xml/cd_catalog.xml"
}

enum APIServiceError: Error {
    case requestFailure
    case invalidEndpoint
    case wrongHttpStatus
    case parseError
}

protocol ItemsServiceProtocol {
    associatedtype ItemType
    typealias ListParserResult = Result<[ItemType], APIServiceError>
    func fetch(completion: @escaping (ListParserResult) -> Void)
}

class CDCatalogService<ItemListParser>: ItemsServiceProtocol where ItemListParser: ListParserProtocol {
    typealias ItemType = ItemListParser.ItemType

    private var parser: ItemListParser
    private let urlSession: URLSession

    init(urlSession: URLSession, parser: ItemListParser) {
        self.urlSession = urlSession
        self.parser = parser
    }

    func fetch(completion: @escaping (ListParserResult) -> Void) {
        
        guard let url = URL(string: Constants.baseURL) else {
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
                    self.parser.parse(key: "cd", data: data, completion: completion)
                case .failure:
                    completion(.failure(.requestFailure))
                }
         }.resume()
    }
}

