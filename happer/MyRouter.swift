//
//  MyRouter.swift
//  happer
//
//  Created by Charles Fournier on 04/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import Router

public class MyRouter: Router {
    enum Routes: String {
        case MyRoute = "route://Main/myViewController#modal"
        case SecondRoute = "route://Main/secondViewController#push"
        case ThirdRoute = "route://Main/thirdViewController#modal"
    }
}
