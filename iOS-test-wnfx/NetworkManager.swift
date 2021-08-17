//
//  NetworkManager.swift
//  iOS-test-wnfx
//
//  Created by Владислав Шушпанов on 17.08.2021.
//

import Foundation


class NetworkManager {
    
    func postRequest(url: String, data: [String: String], completionHandler: @escaping (Int) -> Void) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("text/html", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: data, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode

            completionHandler(status)
            
        } .resume()
    }
    
}
