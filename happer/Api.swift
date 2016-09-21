//
//  Api.swift
//  happer
//
//  Created by paul on 21/09/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Alamofire
import Future

public class Api {
    public static let rootUrl = "http://localhost:8080/"
    public static let webServices = ["connection" : "login.php",
                                     "subscribe" : "adduser.php",
                                     "getUser" : "getUser.php",
                                     "putUser" : "putUser.php",
                                     "postUser" : "postUser.php",
                                     "deleteUser" : "deleteUser.php",
                                     "getSelfie" : "getSelfie.php",
                                     "putSelfie" : "putSelfie.php",
                                     "postSelfie" : "postSelfie.php",
                                     "deleteSelfie" : "deleteSelfie.php",
                                     "getProduct" : "getProduct.php",
                                     "putProduct" : "putProduct.php",
                                     "postProduct" : "postProduct.php",
                                     "deleteProduct" : "deleteProduct.php"]

    /**
     Entry point for all web services request
     */
    public static func request(method:Alamofire.Method, URLString: URLStringConvertible, parameters:[String:AnyObject]? = nil, options: NSJSONReadingOptions = .AllowFragments) -> Future<AnyObject?> {
        let future = Future<AnyObject?>()
        let completion:(Response<AnyObject, NSError> -> Void) = { response in
            print("------------------------------------------------------------")
            print("[STATUS]: \(response.response?.statusCode)")
            print("[HEADERS]: \(response.response?.allHeaderFields)")
            print("[JSON]: \(response.result.value)")
            print("[ERROR]: \(response.result.error)")
            print("[CACHE USAGE]: \(NSURLCache.sharedURLCache().currentMemoryUsage) | \(NSURLCache.sharedURLCache().currentDiskUsage)")
            print("------------------------------------------------------------")
            switch response.result {
            case .Success(let JSON):
                future.resolve(JSON)
            case .Failure(let originalError):
                future.reject(NSError(
                    domain: "com.amazonaws.compute.eu-west-1",
                    code: response.response?.statusCode ?? 42,
                    userInfo: originalError.userInfo))
            }
        }
        Alamofire
            .request(method, URLString, parameters: parameters)
            .validate(statusCode: 200..<400)
            .responseJSON(options: options, completionHandler: completion)
        return future
    }
}
