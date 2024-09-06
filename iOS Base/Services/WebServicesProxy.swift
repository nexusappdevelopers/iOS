//
//  File.swift
//  testt

import UIKit
import Alamofire



protocol AlamofireServices {
    func getdata<T:Decodable,P:Any>(endpoint:ApisEndPoints,queryParam:P,modelType:T.Type) async throws -> T
    func postData<T:Decodable>(endpoint:ApisEndPoints,param:[String:AnyObject],modelType:T.Type) async throws -> T
    func uplaodMedia<T:Decodable>(endpoint:ApisEndPoints,param:[String:AnyObject],modelType:T.Type,imagesWithInfo:[ImageWithInfo],mimeType:String) async throws -> T
}

extension AlamofireServices {
    
    func getdata<T:Decodable,P:Any>(endpoint:ApisEndPoints,queryParam:P,modelType:T.Type) async throws -> T {
        guard let url = URL(string: baseUrl + endpoint.rawValue + "\(queryParam)") else {
            throw NetworkError.invalidUrl
        }
        return try await AF.request(url.absoluteString,method: .get,encoding: JSONEncoding.default).serializingDecodable(T.self).value
    }
    
    
    func postData<T:Decodable>(endpoint:ApisEndPoints,param:[String:AnyObject],modelType:T.Type) async throws -> T {
        guard let url = URL(string: baseUrl + endpoint.rawValue) else {
            throw NetworkError.invalidUrl
        }
        return try await AF.request(url.absoluteString,method:.post, parameters: param,encoding:JSONEncoding.default).serializingDecodable(T.self).value
    }
    
    func uplaodMedia<T:Decodable>(endpoint:ApisEndPoints,param:[String:AnyObject],modelType:T.Type,imagesWithInfo:[ImageWithInfo],mimeType:String = "image/jpeg") async throws -> T {
        guard let url = URL(string: baseUrl + endpoint.rawValue) else {
            throw NetworkError.invalidUrl
        }
      return try await  AF.upload(multipartFormData: { multipartFormData in
            param.forEach { dict in
                multipartFormData.append("\(dict.value)".data(using: .utf8) ?? Data(), withName: dict.key)
            }
            imagesWithInfo.forEach { dict in
                multipartFormData.append(dict.image.jpegData(compressionQuality: 0.5) ?? Data(), withName: dict.key, fileName: "\(UUID().uuidString).jpeg", mimeType: mimeType)
                    }
      }, to: url.absoluteString).serializingDecodable(T.self).value
    }
    
}


































