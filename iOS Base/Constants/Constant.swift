//
//  Constant.swift
//  testt

import UIKit


var baseUrl = ""
enum ApisEndPoints : String {
    case users = "users"
    case userDetail = "user-detail?id="
}



struct ImageWithInfo {
    var image : UIImage
    var key : String
}

enum NetworkError : Error {
    case invalidUrl
    case invalidResponse
    case error(_ error:String)
}
