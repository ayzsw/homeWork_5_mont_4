//
//  APIManager.swift
//  home_work_5_mont_4
//
//  Created by Аяз on 2/6/23.
//

import Foundation


class ApiManager {
    
    static let shared = ApiManager()
    
    func getRequest(completion: @escaping (Result<ProductModel, Error>) -> Void) {
        guard let url = URL(string:"https://dummyjson.com/products")  else {return}
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            
            do {
                let model = try JSONDecoder().decode(ProductModel.self, from: data)
                completion(.success(model))
            } catch  {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func postRequest(id: Int, title: String, completion: @escaping (Result<Int, Error>) -> Void) {
        guard let url = URL(string:"https://dummyjson.com/products/add")  else {return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        let products = ProductModel(products: [.init(id: id, title: title)], total: 1,skip: 1,limit: 1)
        request.httpBody = try? JSONEncoder().encode(products)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {return}
            
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(response.statusCode))
            }
        }
        task.resume()
    }
}
