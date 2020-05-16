//
//  XMLItemListParser.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 17.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

protocol ListParserProtocol {
    associatedtype ItemType
    typealias ListParserResult = Result<[ItemType], APIServiceError>
    func parse(key: String, data: Data, completion: @escaping ((ListParserResult) -> Void))
}

class XMLItemListParser<T>: NSObject, ListParserProtocol, XMLParserDelegate where T:Codable {
    typealias ItemType = T

    private var recordKey: String?
    private var completion: ((ListParserResult) -> Void)?

    private let decoder = JSONDecoder()
    private var result: [T] = []
    private var dictionary: [String: String] = [:]
    private var value: String = ""
    
    func parse(key: String, data: Data, completion: @escaping ((ListParserResult)  -> Void)) {
        let parser = XMLParser(data: data)
        recordKey = key
        parser.delegate = self
        parser.parse()
        completion(.success(result))
    }

    func parserDidStartDocument(_ parser: XMLParser) {
        result = []
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        value += string
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        let elementName = elementName.lowercased()
        if elementName == recordKey {
            dictionary = [:]
        } else {
            value = ""
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let elementName = elementName.lowercased()
        if elementName == recordKey {
            decodeNextElement()
        } else {
            dictionary[elementName] = value
            value = ""
        }
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        completion?(.failure(.parseError))
    }

    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        completion?(.failure(.parseError))
    }

    private func decodeNextElement() {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let value = try decoder.decode(T.self, from: jsonData)
            result.append(value)
        } catch {
            completion?(.failure(.parseError))
        }
    }
}
