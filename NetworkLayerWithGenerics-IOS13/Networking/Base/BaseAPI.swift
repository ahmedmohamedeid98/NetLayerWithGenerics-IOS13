//
//  BaseAPI.swift
//  NetworkLayerWithGenerics-IOS13
//
//  Created by Mac OS on 7/2/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Swift.Result<M, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let header = Alamofire.HTTPHeaders(target.header ?? [:])
        let params = buildParameters(task: target.task)
        /*
         // verision with URLSession and it works
         
        let url = URL(string: target.baseURL + target.path)!
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.header
       
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not get Response"])
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Status Code is not 200"])
                completion(.failure(error))
                return
            }
            
            guard let safeData = data else {
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not get Result"])
                completion(.failure(error))
                return
            }
            
            guard let result = try? JSONDecoder().decode(M.self, from: safeData) else {
                 let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not Parse JSON"])
                 completion(.failure(error))
                 return
            }
            
            completion(.success(result))
        }
        task.resume()
        */
        
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: header).responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode else {
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not get Response"])
                completion(.failure(error))
                return
            }
            
            if statusCode == 200 {
                
                guard let JSONResponse = try? response.result.get() else {
                    // ADD CUSTOM ERROR
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not get Result"])
                    completion(.failure(error))
                    return
                }
                
                guard let JSONData = try? JSONSerialization.data(withJSONObject: JSONResponse, options: []) else {
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not Parse JSON"])
                    completion(.failure(error))
                    return
                }
                
                guard let responseObject = try? JSONDecoder().decode(M.self, from: JSONData) else {
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not Convert JSON to Data"])
                    completion(.failure(error))
                    return
                }
                completion(.success(responseObject))
            } else {
                // 400, 404
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Status Code is not 200"])
                completion(.failure(error))
            }
            
        }
 
        
    }
    
    
    func postData<DE: Decodable>(target: T ,responseClass: DE.Type, completion: @escaping (Result<DE, NSError>) -> ()) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let header = Alamofire.HTTPHeaders(target.header ?? [:])
        let params = buildParameters(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: header).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not get Response"])
                completion(.failure(error))
                return
            }
            
            if statusCode >= 200 && statusCode < 300 {
                
                guard let JSONResponse = try? response.result.get() else {
                    // ADD CUSTOM ERROR
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not get Result"])
                    completion(.failure(error))
                    return
                }
                
                guard let JSONData = try? JSONSerialization.data(withJSONObject: JSONResponse, options: []) else {
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not Parse JSON"])
                    completion(.failure(error))
                    return
                }
                
                guard let responseObject = try? JSONDecoder().decode(DE.self, from: JSONData) else {
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not Convert JSON to Data"])
                    completion(.failure(error))
                    return
                }
                completion(.success(responseObject))
            } else {
                // 400, 404
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: "Status Code is not 200"])
                completion(.failure(error))
            }
        }
        
    }
    
    private func buildParameters(task: Task) -> ([String: Any], ParameterEncoding) {
        switch task {
            
            case .requestPlain:
                return ([:], URLEncoding.default)
            case .requestParameters(let parameters, let encode):
                return (parameters, encode)
        }
    }
}
