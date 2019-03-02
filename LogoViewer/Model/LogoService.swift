//
//  LogoService.swift
//  LogoViewer
//
//  Created by Alex on 02/03/2019.
//  Copyright © 2019 Alexandre Holet. All rights reserved.
//

import Foundation

class LogoService {
    static var shared = LogoService()
    private var task: URLSessionTask?
    
    static private var url = "https://logo.clearbit.com/"
    private init() {}
    
    func getLogo(domain: String, callback: @escaping (Bool, Data?) -> Void) {
        let urlAPI = URL(fileURLWithPath: LogoService.url + domain)
        var request = URLRequest(url: urlAPI)
        request.httpMethod = "GET"
        let body = "size=400"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                callback(false,nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(false,nil)
                return
            }
            callback(true,data)
        })
        task!.resume()
    }
}
