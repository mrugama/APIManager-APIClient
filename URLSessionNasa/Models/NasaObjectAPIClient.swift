//
//  NasaObjectAPIClient.swift
//  URLSessionNasa
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class NasaObjectAPIClient {
    private init() {}
    static let manager = NasaObjectAPIClient()
    func getNasaObject(from urlStr: String, completionHandler: @escaping (NasaObject) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let onlineNasaObject = try JSONDecoder().decode(NasaObject.self, from: data)
                completionHandler(onlineNasaObject)
            } catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
