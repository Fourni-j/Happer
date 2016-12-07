//
//  Api+Actions.swift
//  happer
//
//  Created by Charles Fournier on 07/12/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Future

extension Api {
    
    static func like(selfieId: Int, userId: Int) -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["Like"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let dict = ["like":["selfie_id":selfieId,"user_id":userId]]
        return request(.POST, URLString: urlString, parameters: dict)
    }
    
    static func wish(productId: Int, userId: Int) -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["Wish"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let dict = ["wishe":["product_id":productId,"user_id":userId]]
        return request(.POST, URLString: urlString, parameters: dict)
    }
    
    static func note(selfieId: Int, userId: Int) -> Future<AnyObject?> {
        var urlString = rootUrl + webServices["Note"]!
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let dict = ["note":["selfie_id":selfieId,"user_id":userId]]
        return request(.POST, URLString: urlString, parameters: dict)
    }
}
