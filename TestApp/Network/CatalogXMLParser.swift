//
//  CatalogXMLParser.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 17.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

class XMLItemListParser<T>: NSObject, XMLParserDelegate where T:Codable {
    
    private var recordKey: String?
    private var completion: ((Result<[T], APIServiceError>) -> Void)?

    private let decoder = JSONDecoder()
    private var result: [T] = []
    private var dictionary: [String: String] = [:]
    private var value: String = ""
    
    func parse(key: String, data: Data, completion: @escaping ((Result<[T], APIServiceError>)  -> Void)) {
        recordKey = key
        let parser = XMLParser(data: data)
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

    func decodeNextElement() {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let value = try decoder.decode(T.self, from: jsonData)
            result.append(value)
            dictionary.removeAll()
        } catch {
            completion?(.failure(.parseError))
        }
    }
}

