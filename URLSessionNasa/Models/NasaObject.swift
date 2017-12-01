//
//  NasaObject.swift
//  URLSessionNasa
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation



struct NasaObject: Codable {
    let titleText: String
    let hdurlStr: String?
    let urlStr: String
    
    enum CodingKeys: String, CodingKey {
        case titleText = "title"
        case hdurlStr = "hdurl"
        case urlStr = "url"
    }
}
