//
//  Api+Product.swift
//  happer
//
//  Created by paul on 21/09/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Future

extension Api {
    static func getProduct() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["Product"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.GET, URLString: urlString)
    }

    static func putProduct() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["Product"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.PUT, URLString: urlString)
    }

    static func postProduct() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["Product"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.POST, URLString: urlString)
    }

    static func deleteProduct() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["Product"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.DELETE, URLString: urlString)
    }
}
