//
//  Api+Selfie.swift
//  happer
//
//  Created by paul on 21/09/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Future

extension Api {
    static func getSelfie() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["getSelfie"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.GET, URLString: urlString)
    }

    static func putSelfie() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["putSelfie"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.PUT, URLString: urlString)
    }

    static func postSelfie() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["postSelfie"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.POST, URLString: urlString)
    }

    static func deleteSelfie() -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["deleteSelfie"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return request(.DELETE, URLString: urlString)
    }
}
