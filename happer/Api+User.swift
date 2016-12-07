//
//  Api+User.swift
//  happer
//
//  Created by paul on 21/09/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Future

extension Api {
    static func getUser() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["User"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.GET, URLString: urlString)
    }

    static func putUser() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["User"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.PUT, URLString: urlString)
    }

    static func postUser() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["User"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.POST, URLString: urlString)
    }

    static func deleteUser() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["User"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.DELETE, URLString: urlString)
    }
}
