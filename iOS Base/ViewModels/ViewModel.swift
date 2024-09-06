//
//  viewModel.swift
//  testt

import Foundation
import Alamofire
import UIKit


@MainActor
class ViewModel : AlamofireServices, ObservableObject {
    
    //MARKS: VARIABLES
    @Published var arrUsers : [UserModel] = []
    
    func getUsers() async {
        do {
            arrUsers = try await getdata(endpoint: .users, queryParam: "", modelType: [UserModel].self)
        } catch {
            print(error)
        }
    }
    
    
    
    
    
    
  
}
