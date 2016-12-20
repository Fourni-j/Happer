//
//  Api+Login.swift
//  happer
//
//  Created by Charles Fournier on 20/12/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Future

extension Api {

    static func loginUser(email: String, password: String) -> Future<AnyObject?> {
        var urlString = "http://52.57.64.123/user_token"
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let dict = ["auth":["email":email, "password":password]]
        return request(.POST, URLString: urlString, parameters: dict)
    }
    
}
