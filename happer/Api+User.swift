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

    static func postUser(email: String, password: String, confirm: String) -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["User"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        let dict = ["user":["email":email, "password":password, "confirmation_password":confirm]]
        return request(.POST, URLString: urlString, parameters: dict)
    }

    static func deleteUser() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["User"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.DELETE, URLString: urlString)
    }
}
