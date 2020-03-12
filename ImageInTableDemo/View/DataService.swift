//
//  DataService.swift
//  WiproDemoProject
//
//  Created by Nitu Kumari on 04/03/20.
//  Copyright © 2020 Nitu Kumari. All rights reserved.
//

import Foundation

struct DataService {

// MARK: - Singleton
static let shared = DataService()
private let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
    
func getApiCall(completion: @escaping (_ jsonData: Any?, _ error: String?)->()) {
       
     
             
            
       let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
           if error != nil {
               completion(nil, "Error")
               return
           }
           
           if let response = response as? HTTPURLResponse {
               let result = ResponseStatusHandler.handleNetworkResponse(response)
               switch result {
               case .success:
                   guard let responseData = data else {
                       
                       
                       completion(nil, ResponseStatus.noData.rawValue)
                       return
                   }
                   do {
                       let utf8Data = String(decoding: responseData, as: UTF8.self).data(using: .utf8)
                       let userDetails = try JSONDecoder().decode(UserDetails.self, from:utf8Data!)
                       completion(userDetails,nil)
                       
                   }catch {
                       print(error)
                       completion(nil, ResponseStatus.unableToDecode.rawValue)
                   }
               case .failure(let error):
                   completion(nil, error)
               }
           }
           
       }
       
       task.resume()
   }
}
