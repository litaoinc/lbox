//
//  RestAPI.swift
//  LoveBox
//
//  Created by kx on 2019/1/4.
//  Copyright © 2019年 shu. All rights reserved.
//

import UIKit

class RestAPI: NSObject {
    public static let BASE_URL = "https://39.104.113.123"
    public static let ACCOUNT = "/account"
    public static let LOGIN = RestAPI.BASE_URL + "/login"
    public static let REGISTY = RestAPI.BASE_URL + "/registy"
}
